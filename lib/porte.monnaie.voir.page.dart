import 'package:flutter/material.dart';
import 'package:tspay/page.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';

class PorteMonnaieVoirPage extends StatefulWidget {
  const PorteMonnaieVoirPage({Key? key}) : super(key: key);

  @override
  _PorteMonnaieVoirPageState createState() => _PorteMonnaieVoirPageState();
}

class _PorteMonnaieVoirPageState extends State<PorteMonnaieVoirPage> {
  final _numeroFormKey = GlobalKey<FormState>();
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  TextEditingController numeroController =
      TextEditingController(text: '6 76 54 34 95');

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
              "Porte-monnaie électronique 6965454322",
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
              "MTN Cameroun",
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
              action: () {},
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
