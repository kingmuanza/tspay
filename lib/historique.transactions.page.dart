import 'package:flutter/material.dart';
import 'package:tspay/page.dart';
import 'package:tspay/paiement.effectue.page.dart';
import 'package:intl/intl.dart';

class HistoriqueTransactionsPage extends StatefulWidget {
  const HistoriqueTransactionsPage({Key? key}) : super(key: key);

  @override
  _HistoriqueTransactionsPageState createState() =>
      _HistoriqueTransactionsPageState();
}

class _HistoriqueTransactionsPageState
    extends State<HistoriqueTransactionsPage> {
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");
  Widget contenu() {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
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
            child: Text(
              "Historique des transations",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: double.infinity,
            child: Text(
              "Aenean metus metus, fringilla id nisl ut, laoreet interdum eros. Nullam eget sodales nulla. Morbi vel nulla tortor",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w100,
              ),
            ),
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

  Widget transactions() {
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

  Widget PetitBox(String libelle, int montant, [String? unite]) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
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
            margin: EdgeInsets.only(top: 0),
            width: double.infinity,
            child: setLibelle(montant, unite),
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Wax Vestimentaire",
              style: TextStyle(color: Colors.white),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
            ),
          ),
          unite != null
              ? TextSpan(
                  text: " " + unite,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
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
