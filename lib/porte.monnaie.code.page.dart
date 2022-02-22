import 'package:flutter/material.dart';
import 'package:tspay/accueil.page.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/models/porte.monnaie.model.dart';
import 'package:tspay/page.dart';
import 'package:tspay/porte.monnaie.page.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';
import 'package:localstorage/localstorage.dart';

class PorteMonnaieCodePage extends StatefulWidget {
  final PorteMonnaie porteMonnaie;
  final String code;
  const PorteMonnaieCodePage({
    Key? key,
    required this.porteMonnaie,
    required this.code,
  }) : super(key: key);

  @override
  _PorteMonnaieCodePageState createState() => _PorteMonnaieCodePageState();
}

class _PorteMonnaieCodePageState extends State<PorteMonnaieCodePage> {
  TextEditingController montantController = TextEditingController(text: '');
  final LocalStorage storage = new LocalStorage('tspay');

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
                String code = storage.getItem("tspaycode");
                if (montantController.text == code) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PorteMonnaiePage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Code incorrect")),
                  );
                }
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
