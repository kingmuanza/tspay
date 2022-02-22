import 'package:flutter/material.dart';
import 'package:tspay/page.dart';
import 'package:tspay/porte.monnaie.page.dart';
import 'package:tspay/services/porte.monnaie.service.dart';
import 'package:tspay/services/qrcode.service.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';
import 'models/porte.monnaie.model.dart';

class PorteMonnaieVoirPage extends StatefulWidget {
  final PorteMonnaie porteMonnaie;
  const PorteMonnaieVoirPage({Key? key, required this.porteMonnaie})
      : super(key: key);

  @override
  _PorteMonnaieVoirPageState createState() => _PorteMonnaieVoirPageState();
}

class _PorteMonnaieVoirPageState extends State<PorteMonnaieVoirPage> {
  final _numeroFormKey = GlobalKey<FormState>();
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  TextEditingController numeroController =
      TextEditingController(text: '6 76 54 34 95');

  PorteMonnaieService porteMonnaieService = PorteMonnaieService();
  QRCodeService qRCodeService = QRCodeService();

  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
              "Porte-monnaie électronique " + widget.porteMonnaie.numero!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              "Aenean metus metus, fringilla id nisl ut, laoreet interdum eros. Suspendisse potenti. Morbi vel nulla tortor",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              qRCodeService
                  .detecterOperateurMobile(widget.porteMonnaie.numero!),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 32),
            child: Bouton(
              largeur: 200,
              nom: "Supprimer",
              action: () {
                porteMonnaieService.supprimer(widget.porteMonnaie).then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PorteMonnaiePage(),
                        ),
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(
      child: contenu(),
      index: 3,
      backable: true,
    );
  }
}
