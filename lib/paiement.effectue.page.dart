import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/models/paiement.model.dart';
import 'package:tspay/page.dart';
import 'package:intl/intl.dart';

import 'accueil.page.dart';
import 'historique.transactions.page.dart';

class PaiementEffectuePage extends StatefulWidget {
  final Paiement paiement;
  bool? entrant = true;
  PaiementEffectuePage({
    Key? key,
    required this.paiement,
    this.entrant,
  }) : super(key: key);

  @override
  _PaiementEffectuePageState createState() => _PaiementEffectuePageState();
}

class _PaiementEffectuePageState extends State<PaiementEffectuePage> {
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");
  String libelle =
      "Paiement effectué. Vous allez recevoir le montant sur votre Mobile Money ";

  Widget contenu() {
    bool entrant = widget.entrant != null ? widget.entrant! : true;
    String libelle = entrant
        ? "Paiement effectué. Vous allez recevoir le montant sur votre Mobile Money "
        : "Paiement effectué. Le montant a été retiré de votre Mobile Money ";
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
              "Paiement de " +
                  formatCurrency.format(widget.paiement.montant) +
                  " XAF",
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
              libelle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 200,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32, bottom: 64),
            width: double.infinity,
            child: Text(
              "Paiement effectué",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          entrant
              ? Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Bouton(
                    largeur: 150,
                    nom: "Revenir à l'accueil",
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccueilPage(),
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Bouton(
                    largeur: 150,
                    nom: "Historique des transactions",
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoriqueTransactionsPage(),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(
      child: Container(
        child: contenu(),
      ),
      index: 1,
      backable: false,
    );
  }
}
