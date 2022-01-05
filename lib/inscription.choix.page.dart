import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/inscription.formulaire.page.dart';

class InscriptionChoixPage extends StatefulWidget {
  const InscriptionChoixPage({Key? key}) : super(key: key);

  @override
  _InscriptionChoixPageState createState() => _InscriptionChoixPageState();
}

class _InscriptionChoixPageState extends State<InscriptionChoixPage> {
  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 34, 1)),
        padding: EdgeInsets.symmetric(horizontal: 32),
        height: hauteur,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: EnteteGauche()),
                Container(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 180,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GrosBouton(
                titre: "Compte professionel",
                contenu:
                    "Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit. ",
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InscriptionFormulairePage(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GrosBouton(
                titre: "Compte Particulier",
                contenu:
                    "Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit. ",
                action: () {},
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class EnteteGauche extends StatelessWidget {
  const EnteteGauche({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Inscription",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        Text(
          "Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor.",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
