import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/composants/champ.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/generer.qrcode.page.dart';
import 'package:tspay/models/paiement.model.dart';
import 'package:tspay/page.dart';
import 'package:tspay/services/qrcode.service.dart';
import 'package:tspay/services/utilisateur.service.dart';
import 'package:intl/intl.dart';

import 'models/utilisateur.model.dart';

class GenererPage extends StatefulWidget {
  const GenererPage({Key? key}) : super(key: key);

  @override
  _GenererPageState createState() => _GenererPageState();
}

class _GenererPageState extends State<GenererPage> {
  TextEditingController montantController = TextEditingController(text: '0');
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");
  int montant = 0;

  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32),
            width: double.infinity,
            child: Typographie.appTitre("Gérérer un paiement"),
          ),
          Container(
            width: double.infinity,
            child: Typographie.appSousTitre(
                "Vous aller générer un code de paiement de " +
                    formatCurrency.format(montant) +
                    " XAF"),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: Champ(
                labelText: "Montant du paiement",
                controller: montantController,
                clavier: TextInputType.number,
                onChanged: (value) {
                  montant = int.parse(value);
                  print(value);
                  print(montant);
                  setState(() {});
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Bouton(
              largeur: 120,
              nom: "Continuer",
              action: () {
                if (int.parse(montantController.text) > 0) {
                  this
                      .genererPaiement(int.parse(montantController.text))
                      .then((paiement) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenererQRCodePage(
                          paiement: paiement,
                        ),
                      ),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Le montant doit être supérieur à 0"),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Paiement> genererPaiement(int montant) async {
    UtilisateurService utilisateurService = UtilisateurService();
    Utilisateur? utilisateur = await utilisateurService.getLocalUtilisateur();
    Paiement paiement = Paiement(montant);
    if (utilisateur != null) {
      paiement.idutilisateur = utilisateur.id;
      paiement.nom = (utilisateur.noms != null ? utilisateur.noms! : "") +
          " " +
          (utilisateur.prenoms != null ? utilisateur.prenoms! : "");

      paiement.numero = utilisateur.id;
    }
    print("paiement");
    print(paiement.toMap());
    QRCodeService qRCodeService = QRCodeService();
    await qRCodeService.creer(paiement);
    return paiement;
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 1);
  }
}
