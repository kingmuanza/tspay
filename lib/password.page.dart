import 'package:flutter/material.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _nomFormKey = GlobalKey<FormState>();
  final _prenomFormKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController(text: 'Muanza');
  TextEditingController prenomController =
      TextEditingController(text: 'Kangudie');

  bool checkedValue = false;

  showAlertDialog(BuildContext context) {
    // set up the button
    double largeur = MediaQuery.of(context).size.width;
    Widget okButton = Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Bouton(
        largeur: double.infinity,
        nom: "Me connecter",
        secondaire: true,
        action: () {},
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Votre compte a bien été créé !"),
      content: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non convallis erat, non fringilla orci. Etiam lobortis nisl ut turpis lacinia, vitae feugiat purus tristique."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
        child: SingleChildScrollView(
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
                labelText: 'Mot de passe',
                formKey: _nomFormKey,
                controller: nomController,
                clavier: TextInputType.visiblePassword,
                isPassword: true,
              ),
              Champ(
                labelText: 'Confirmation mot de passe',
                formKey: _prenomFormKey,
                controller: prenomController,
                isPassword: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Bouton(
                  nom: "Terminer",
                  largeur: largeur / 2,
                  action: () {
                    showAlertDialog(context);
                  },
                ),
              ),
            ],
          ),
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
            "Mot de passe",
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
