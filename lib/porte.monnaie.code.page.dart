import 'package:flutter/material.dart';
import 'package:tspay/accueil.page.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/page.dart';
import 'package:tspay/porte.monnaie.page.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';

class PorteMonnaieCodePage extends StatefulWidget {
  const PorteMonnaieCodePage({Key? key}) : super(key: key);

  @override
  _PorteMonnaieCodePageState createState() => _PorteMonnaieCodePageState();
}

class _PorteMonnaieCodePageState extends State<PorteMonnaieCodePage> {
  TextEditingController montantController =
      TextEditingController(text: '-  -  -  -');

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
            child: Typographie.appTitre("Code de vérification"),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: double.infinity,
            child: Typographie.appSousTitre(
              "Aenean metus metus, fringilla id nisl ut, laoreet interdum eros. Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor",
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Champ(
              labelText: "Entrez le code ici",
              controller: montantController,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Bouton(
              largeur: 120,
              nom: "Valider",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PorteMonnaiePage(),
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
