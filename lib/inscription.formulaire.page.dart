import 'package:flutter/material.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';

class InscriptionFormulairePage extends StatefulWidget {
  const InscriptionFormulairePage({Key? key}) : super(key: key);

  @override
  _InscriptionFormulairePageState createState() =>
      _InscriptionFormulairePageState();
}

class _InscriptionFormulairePageState extends State<InscriptionFormulairePage> {
  final _nomFormKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController(text: 'Muanza');

  @override
  Widget build(BuildContext context) {
    String labelText = "Noms";
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 34, 1)),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        height: hauteur,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16),
              child: EnteteGauche(),
            ),
            Champ(
              labelText: 'Noms',
              formKey: _nomFormKey,
              controller: nomController,
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
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
