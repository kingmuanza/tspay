import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/connexion.page.dart';
import 'package:tspay/inscription.particulier.page.dart';
import 'package:tspay/inscription.professionnel.page.dart';

import 'composants/typographie.dart';

class InscriptionChoixPage extends StatefulWidget {
  const InscriptionChoixPage({Key? key}) : super(key: key);

  @override
  _InscriptionChoixPageState createState() => _InscriptionChoixPageState();
}

class _InscriptionChoixPageState extends State<InscriptionChoixPage> {
  Widget entete() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Typographie.titre("Inscription"),
                Typographie.sousTitre(
                    "Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti"),
              ],
            ),
          ),
        ),
        Container(
          width: 60,
          child: Typographie.logo(60),
        ),
      ],
    );
  }

  Widget professionnel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GrosBouton(
        titre: "Compte professionel",
        contenu:
            "Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit. ",
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InscriptionProfessionnelPage(),
            ),
          );
        },
      ),
    );
  }

  Widget particulier() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GrosBouton(
        titre: "Compte Particulier",
        contenu:
            "Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit. ",
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InscriptionParticulierPage(),
            ),
          );
        },
      ),
    );
  }

  Widget connexion() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Vous disposez déjà d'un compte ? ",
            ),
            TextSpan(
                text: "Connectez-vous ici",
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Connectez-vous ici');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConnexionPage(),
                      ),
                    );
                  }),
          ],
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
        height: hauteur,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: entete(),
            ),
            professionnel(),
            particulier(),
            connexion(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
