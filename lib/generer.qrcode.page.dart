import 'package:flutter/material.dart';
import 'package:tspay/page.dart';
import 'package:tspay/paiement.effectue.page.dart';

import 'composants/bouton.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'models/paiement.model.dart';

class GenererQRCodePage extends StatefulWidget {
  final Paiement paiement;
  const GenererQRCodePage({Key? key, required this.paiement}) : super(key: key);

  @override
  _GenererQRCodePageState createState() => _GenererQRCodePageState();
}

class _GenererQRCodePageState extends State<GenererQRCodePage> {
  final formatCurrency = new NumberFormat.decimalPattern("fr_FR");
  String libelle = "Veuillez patienter pendant la génération de votre QR Code ";
  bool codeGenere = false;
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
            margin: EdgeInsets.only(
              top: 32,
              left: 0,
            ),
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
            margin: EdgeInsets.only(
              top: 8,
              left: 0,
            ),
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
          codeGenere
              ? Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.only(top: 32),
                  width: largeur,
                  child: QrImage(
                    data: genererData(),
                    version: QrVersions.auto,
                    size: largeur,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                )
              : Container(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaiementEffectuePage(
                    paiement: widget.paiement,
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

  String genererData() {
    String data = widget.paiement.toMap().toString();
    print("genererData");
    print(data);
    return widget.paiement.id!;
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      libelle = "Votre code est prêt à être scanné";
      codeGenere = true;
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
