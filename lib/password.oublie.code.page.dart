import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/password.page.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';
import 'composants/typographie.dart';

class PasswordOublieCodePage extends StatefulWidget {
  final String code;
  const PasswordOublieCodePage({Key? key, required this.code})
      : super(key: key);

  @override
  _PasswordOublieCodePageState createState() => _PasswordOublieCodePageState();
}

class _PasswordOublieCodePageState extends State<PasswordOublieCodePage> {
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
            margin: EdgeInsets.only(top: 0),
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
                      builder: (context) => PasswordPage(
                        changement: true,
                      ),
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
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 34, 1)),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        height: hauteur,
        child: SingleChildScrollView(
          child: contenu(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
