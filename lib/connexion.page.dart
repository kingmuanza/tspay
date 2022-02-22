import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/accueil.page.dart';
import 'package:tspay/composants/champ.dart';
import 'package:tspay/inscription.choix.page.dart';
import 'package:tspay/services/utilisateur.service.dart';

import 'composants/bouton.dart';
import 'composants/typographie.dart';
import 'exceptions/auth.exception.dart';
import 'models/utilisateur.model.dart';

class ConnexionPage extends StatefulWidget {
  bool? backable = true;
  String? tel = "";
  ConnexionPage({Key? key, this.backable, this.tel}) : super(key: key);

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _passeFormKey = GlobalKey<FormState>();
  final _numeroFormKey = GlobalKey<FormState>();
  TextEditingController numeroController =
      TextEditingController(text: '696543495');
  TextEditingController passeController = TextEditingController(text: 'Muanza');
  TextEditingController indicatifController =
      TextEditingController(text: '+237');

  Widget formulaire() {
    if (widget.tel != null) {
      numeroController.text = widget.tel!;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                padding: EdgeInsets.only(right: 10),
                child: Champ(
                  labelText: 'Indicatif',
                  controller: indicatifController,
                  readOnly: true,
                ),
              ),
              Expanded(
                child: Champ(
                  labelText: "Numéro de téléphone",
                  controller: numeroController,
                  clavier: TextInputType.phone,
                  key: _numeroFormKey,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 24),
          child: Champ(
            labelText: "Mot de passe",
            controller: passeController,
            key: _passeFormKey,
            isPassword: true,
          ),
        ),
        passeOublie(),
        Container(
          alignment: Alignment.topLeft,
          child: Bouton(
            largeur: 200,
            nom: "Se connecter",
            action: () {
              getUtilisateur();
            },
          ),
        ),
      ],
    );
  }

  Widget passeOublie() {
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 24),
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "Mot de passe oublié ",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white70,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Inscrivez-vous ici');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InscriptionChoixPage(),
                      ),
                    );
                  }),
          ],
        ),
      ),
    );
  }

  Widget inscription() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Vous ne disposez pas de compte ? ",
            ),
            TextSpan(
                text: " Inscrivez-vous ici",
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Inscrivez-vous ici');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InscriptionChoixPage(),
                      ),
                    );
                  }),
          ],
        ),
      ),
    );
  }

  Widget contenu() {
    double hauteur = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 34, 1)),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
      height: hauteur,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Typographie.titre('Connexion'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Typographie.logo(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Typographie.sousTitre(
                "Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor ed gravida nunc."),
          ),
          formulaire(),
          inscription()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => widget.backable != null ? widget.backable! : true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: contenu(),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  getUtilisateur() {
    var tel = numeroController.text;
    var passe = passeController.text;
    connexion(tel.split(' ').join('').split('-').join(''), passe).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccueilPage(),
        ),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    });
  }

  Future<Utilisateur> connexion(String id, String passe) async {
    print("La connexion dans la page connexion");
    UtilisateurService utilisateurService = UtilisateurService();
    try {
      Utilisateur utilisateur = await utilisateurService.connexion(id, passe);
      utilisateur.derniereConnexion = DateTime.now();

      return utilisateur;
    } on Exception catch (e) {
      print("Quelles sont les erreurs");
      print(e);
      throw AuthException("Login ou mot de passe incorrect");
    }
  }
}
