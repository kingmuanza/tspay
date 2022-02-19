import 'package:flutter/material.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/models/paiement.model.dart';
import 'package:tspay/page.dart';
import 'package:tspay/paiement.effectue.page.dart';
import 'package:intl/intl.dart';
import 'package:tspay/services/utilisateur.service.dart';

import 'models/utilisateur.model.dart';
import 'services/qrcode.service.dart';

class HistoriqueTransactionsPage extends StatefulWidget {
  final Utilisateur utilisateur;
  const HistoriqueTransactionsPage({Key? key, required this.utilisateur})
      : super(key: key);

  @override
  _HistoriqueTransactionsPageState createState() =>
      _HistoriqueTransactionsPageState();
}

class _HistoriqueTransactionsPageState
    extends State<HistoriqueTransactionsPage> {
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");
  UtilisateurService utilisateurService = UtilisateurService();
  Utilisateur? utilisateur = Utilisateur("");

  List<Paiement> paiements = [];

  @override
  initState() {
    super.initState();
    this.init();
  }

  init() async {
    print("historique init");
    utilisateur = await utilisateurService.getLocalUtilisateur();
    if (utilisateur != null) {
      print("historique utilisateur init");
      if (utilisateur!.id != null) {
        print("historique utilisateur id init");
        QRCodeService qrCodeService = QRCodeService();
        qrCodeService.historique(utilisateur!.id!).then((all) {
          print("paiements recus...............................1");
          print("paiements recus...............................2");
          print("paiements recus...............................3");
          this.paiements = all;
          all.forEach((a) {
            print(a.toMap());
          });
          setState(() {});
        });
      }
    }
  }

  Widget contenu() {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Typographie.appTitre("Historique des transations"),
          Container(
            child: Typographie.appSousTitre((widget.utilisateur.noms != null
                    ? widget.utilisateur.noms!
                    : "Aucun") +
                " " +
                (widget.utilisateur.prenoms != null
                    ? widget.utilisateur.prenoms!
                    : "utilisateur")),
            margin: EdgeInsets.only(bottom: 16.0),
          ),
          transactions(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(
      child: contenu(),
      index: 0,
      backable: true,
    );
  }

  String libelle(Paiement paiement) {
    print("paiement.idutilisateur");
    print(paiement.idutilisateur);
    print("utilisateur!.id");
    print(utilisateur!.id);
    print(paiement.idutilisateur == utilisateur!.id);
    String phrase = "";
    String jour = "";
    String heure = "";
    if (paiement.datePaiement != null) {
      jour = paiement.datePaiement!.toIso8601String().split('T')[0];
      heure =
          paiement.datePaiement!.toIso8601String().split('T')[1].split(".")[0];
    } else {
      jour = paiement.dateGeneration!.toIso8601String().split('T')[0];
      heure = paiement.dateGeneration!
          .toIso8601String()
          .split('T')[1]
          .split(".")[0];
    }

    if (paiement.idutilisateur == utilisateur!.id) {
      phrase = "Reçu le ";
    } else {
      phrase = "Payé le ";
    }
    phrase = phrase + jour + " à " + heure;
    return phrase;
  }

  Widget transactions() {
    return Column(
      children: [
        for (var paiement in paiements)
          Container(
            child: PetitBox(paiement),
          ),
      ],
    );
  }

  Widget PetitBox(Paiement paiement) {
    String nomRecepteur = "";
    if (paiement.idutilisateur == utilisateur!.id) {
      if (paiement.nompayeur != null) {
        nomRecepteur = paiement.nompayeur!;
      } else {
        nomRecepteur = "Payeur non identifié";
      }
    } else {
      nomRecepteur = paiement.nom!;
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.075),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    libelle(paiement),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  width: double.infinity,
                  child: setLibelle(paiement.montant, "XAF"),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    nomRecepteur,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 50,
            child: Icon(
              paiement.idutilisateur == utilisateur!.id
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color: Colors.white54,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget setLibelle(int montant, String? unite) {
    return RichText(
      textAlign: unite != null ? TextAlign.left : TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: formatCurrency.format(montant),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
            ),
          ),
          unite != null
              ? TextSpan(
                  text: " " + unite,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 0.1,
                  ),
                )
              : TextSpan(),
        ],
      ),
    );
  }
}
