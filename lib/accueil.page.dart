import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/connexion.page.dart';
import 'package:tspay/models/utilisateur.model.dart';
import 'package:tspay/page.dart';
import 'package:tspay/services/utilisateur.service.dart';
import 'package:intl/intl.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  UtilisateurService utilisateurService = UtilisateurService();
  Utilisateur utilisateur = Utilisateur("");
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");

  @override
  initState() {
    super.initState();
    this.init();
  }

  init() async {
    utilisateur = await utilisateurService.getLocalUtilisateur();
    setState(() {});
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
              (utilisateur.noms != null ? utilisateur.noms! : "Aucun") +
                  " " +
                  (utilisateur.prenoms != null
                      ? utilisateur.prenoms!
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
              "Particulier",
              style: TextStyle(
                color: Colors.white,
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
            child: Box("Solde", 1250000, "XAF"),
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
      child: Box("Montant total des paiements", 12250000, "XAF"),
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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5),
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
        ],
      ),
    );
  }

  Widget sixiemeLigne() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.infinity,
      child: Text(
        "Historique des transactions",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget Box(String libelle, int montant, [String? unite]) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10,
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
                top: 10,
                left: 16,
                right: 16,
              ),
              width: double.infinity,
              child: setLibelle(montant, unite)),
        ],
      ),
    );
  }

  Widget PetitBox(String libelle, int montant, [String? unite]) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              libelle,
              textAlign: unite != null ? TextAlign.left : TextAlign.right,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: double.infinity,
            child: setLibelle(montant, unite),
          ),
        ],
      ),
    );
  }

  Widget GrosBox(String libelle, Widget element) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 150,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
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

  Widget spetiemeLigne() {
    List<int> text = [1, 2, 3, 4];
    return Column(
      children: [
        for (var i in text)
          Container(
            child: PetitBox("Dépôt : 2021/11/02 à 14:05", 750000, "XAF"),
          ),
      ],
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
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
            ),
          ),
          unite != null
              ? TextSpan(
                  text: " " + unite!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 0.1,
                  ),
                )
              : TextSpan(),
        ],
      ),
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
              troisiemeLigne(),
              quatriemeLigne(),
              cinquiemeLigne(),
              sixiemeLigne(),
              spetiemeLigne(),
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
