import 'package:flutter/material.dart';
import 'package:tspay/inscription.choix.page.dart';

import 'composants/bouton.dart';
import 'connexion.page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 34, 1)),
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: hauteur,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 180,
                ),
              ),
            ),
            Text(
              "Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit. Aenean metus metus, fringilla id nisl ut, laoreet interdum eros. Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor.",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: Bouton(
                largeur: largeur,
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConnexionPage(),
                    ),
                  );
                },
                nom: "Connexion",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Bouton(
                largeur: largeur,
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InscriptionChoixPage(),
                    ),
                  );
                },
                nom: "Inscription",
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
