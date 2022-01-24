import 'package:flutter/material.dart';
import 'package:tspay/page.dart';
import 'package:tspay/paiement.effectue.page.dart';

import 'composants/bouton.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenererQRCodePage extends StatefulWidget {
  final int montant;
  const GenererQRCodePage({Key? key, required this.montant}) : super(key: key);

  @override
  _GenererQRCodePageState createState() => _GenererQRCodePageState();
}

class _GenererQRCodePageState extends State<GenererQRCodePage> {
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");
  String libelle = "Veuillez patienter pendant la génération de votre QR Code ";
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
              "Paiement de " + formatCurrency.format(widget.montant) + " XAF",
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
            width: largeur,
            child: QrImage(
              data: "{montant : " + formatCurrency.format(widget.montant) + "}",
              version: QrVersions.auto,
              size: largeur,
              foregroundColor: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaiementEffectuePage(
                    montant: widget.montant,
                  ),
                ),
              );
            },
            child: Text("Simuler la suite"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      libelle = "Votre code est prêt à être scanné";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(
      child: contenu(),
      index: 1,
      backable: true,
    );
  }
}
