import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/connexion.page.dart';
import 'package:tspay/generer.page.dart';
import 'package:tspay/models/utilisateur.model.dart';
import 'package:tspay/page.dart';
import 'package:tspay/pay.page.dart';
import 'package:tspay/services/qrcode.service.dart';
import 'package:tspay/services/utilisateur.service.dart';
import 'package:intl/intl.dart';

import 'historique.transactions.page.dart';
import 'models/paiement.model.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  UtilisateurService utilisateurService = UtilisateurService();
  Utilisateur? utilisateur = Utilisateur("");
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");
  List<Paiement> paiements = [];
  List<Paiement> paiementsR = [];
  List<Paiement> paiementsE = [];

  int solde = 0;

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
        qrCodeService.paiementsEmis(utilisateur!.id!).then((all) {
          this.paiementsE = all;

          qrCodeService.paiementsRecus(utilisateur!.id!).then((all2) {
            this.paiementsR = all2;
            solde = totalPaiements(paiementsR) - totalPaiements(paiementsE);

            qrCodeService.historique(utilisateur!.id!).then((all3) {
              this.paiements = all3.sublist(0, 2);
              setState(() {});
            });
          });
        });
      }
    }
  }

  int totalPaiements(List<Paiement> all) {
    int total = 0;
    all.forEach((element) {
      total += element.montant;
    });
    return total;
  }

  Widget infosPersonnelles() {
    return Container(
      height: 50,
      // color: Colors.blue,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              (utilisateur!.noms != null ? utilisateur!.noms! : "Aucun") +
                  " " +
                  (utilisateur!.prenoms != null
                      ? utilisateur!.prenoms!
                      : "utilisateur"),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              utilisateur!.commerce != null
                  ? utilisateur!.commerce!
                  : "Particulier",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget premiereLigne() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(child: infosPersonnelles()),
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.topRight,
            // color: Colors.red,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.white,
                size: 30,
              ),
              padding: EdgeInsets.only(top: 5),
              constraints: BoxConstraints(),
            ),
          )
        ],
      ),
    );
  }

  Widget deuxiemeLigne() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Box("Solde", solde, "XAF"),
          ),
        ),
        Container(
          width: 80,
          margin: EdgeInsets.only(left: 10),
          child: Box("Points", 0),
        )
      ],
    );
  }

  Widget troisiemeLigne() {
    return Container(
      child: Box("Montant total des paiements du jour", 0, "XAF"),
    );
  }

  Widget quatriemeLigne() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.infinity,
      child: Text(
        "Accès rapide",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget cinquiemeLigne() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenererPage(),
                    ),
                  );
                },
                child: GrosBox(
                    "Générer un code de paiement",
                    Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayPage(),
                    ),
                  );
                },
                child: GrosBox(
                    "Effectuer un paiement",
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "PAY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sixiemeLigne() {
    return InkWell(
      onTap: () {
        print("Historique des transactions");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoriqueTransactionsPage(
              utilisateur: utilisateur!,
            ),
          ),
        );
      },
      child: paiements.length > 0
          ? Container(
              margin: EdgeInsets.only(top: 16),
              width: double.infinity,
              child: Text(
                "Dernières transactions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          : Container(),
    );
  }

  Widget Box(String libelle, int montant, [String? unite, double? opacite]) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 72,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, opacite != null ? opacite : 0.2),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            child: Text(
              libelle,
              textAlign: unite != null ? TextAlign.left : TextAlign.right,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 4,
                left: 16,
                right: 16,
              ),
              width: double.infinity,
              child: setLibelle(montant, unite)),
        ],
      ),
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

  Widget GrosBox(String libelle, Widget element) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 150,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            margin: EdgeInsets.only(
              top: 10,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            child: Text(
              libelle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              top: 24,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            child: element,
          ),
        ],
      ),
    );
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

  Widget contenu() {
    return SingleChildScrollView(
      child: Container(
          width: double.infinity,
          // padding: EdgeInsets.only(top: 64),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 34, 1),
          ),
          child: Column(
            children: [
              premiereLigne(),
              deuxiemeLigne(),
              // troisiemeLigne(),
              // quatriemeLigne(),
              // cinquiemeLigne(),
              sixiemeLigne(),
              transactions(),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(vertical: 12),
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoriqueTransactionsPage(
                          utilisateur: utilisateur!,
                        ),
                      ),
                    )
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(50, 30),
                    alignment: Alignment.topLeft,
                  ),
                  child: Text(
                    "Voir toutes les transactions",
                    style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.white, offset: Offset(0, -8))
                      ],
                      color: Colors.transparent,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(
      index: 0,
      child: contenu(),
    );
  }
}
