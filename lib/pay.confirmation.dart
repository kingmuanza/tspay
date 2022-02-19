import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/historique.transactions.page.dart';
import 'package:tspay/models/utilisateur.model.dart';
import 'package:tspay/page.dart';
import 'package:tspay/paiement.effectue.page.dart';
import 'package:intl/intl.dart';
import 'package:tspay/services/qrcode.service.dart';
import 'package:tspay/services/utilisateur.service.dart';

import 'models/paiement.model.dart';

class PayConfirmationPage extends StatefulWidget {
  final Paiement paiement;
  const PayConfirmationPage({Key? key, required this.paiement})
      : super(key: key);

  @override
  _PayConfirmationPageState createState() => _PayConfirmationPageState();
}

class _PayConfirmationPageState extends State<PayConfirmationPage> {
  UtilisateurService utilisateurService = UtilisateurService();
  Utilisateur? utilisateur = Utilisateur("");

  @override
  initState() {
    super.initState();
    this.init();
  }

  init() async {
    utilisateur = await utilisateurService.getLocalUtilisateur();
    setState(() {});
  }

  double size = 22;
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");

  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 32),
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Vous allez effectuer un paiement de ",
                      style: TextStyle(fontSize: size),
                    ),
                    TextSpan(
                      text: formatCurrency.format(widget.paiement.montant) +
                          " XAF",
                      style: TextStyle(fontSize: size),
                    ),
                    TextSpan(
                      text: " à ",
                      style: TextStyle(fontSize: size),
                    ),
                    TextSpan(
                      text: widget.paiement.nom,
                      style: TextStyle(
                        fontSize: size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.only(top: 64),
            width: double.infinity,
            child: Text(
              "Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit. ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 32, bottom: 72),
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            width: double.infinity,
            height: 100,
          ),
          Bouton(
              largeur: 100,
              nom: "Payer",
              action: () {
                payer(widget.paiement).then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoriqueTransactionsPage(utilisateur: utilisateur!),
                    ),
                  );
                });
              })
        ],
      ),
    );
  }

  Future payer(Paiement paiement) async {
    if (paiement.idutilisateur == utilisateur!.id!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Vous ne pouvez pas effectuer un paiement sur votre propre compte"),
        ),
      );
    } else {
      paiement.idpayeur = utilisateur!.id;
      if (utilisateur!.commerce != null) {
        paiement.nompayeur = utilisateur!.commerce;
      } else {
        paiement.nompayeur = utilisateur!.noms! + " " + utilisateur!.prenoms!;
      }
      paiement.datePaiement = DateTime.now();
      paiement.statut = 1;
      QRCodeService qRCodeService = new QRCodeService();
      await qRCodeService.save(paiement);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(
      child: contenu(),
      index: 2,
      backable: true,
    );
  }
}
