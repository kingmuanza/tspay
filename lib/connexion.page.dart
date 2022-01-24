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
import 'exceptions/auth.exception.dart';
import 'inscription.particulier.page.dart';
import 'models/utilisateur.model.dart';

class ConnexionPage extends StatefulWidget {
  bool? backable = true;
  ConnexionPage({Key? key, this.backable}) : super(key: key);

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final LocalStorage storage = new LocalStorage('tspay');
  final utilisateursFirebase =
      FirebaseFirestore.instance.collection('utilisateurs');
  final _passeFormKey = GlobalKey<FormState>();
  final _numeroFormKey = GlobalKey<FormState>();
  TextEditingController numeroController =
      TextEditingController(text: '696543495');
  TextEditingController passeController = TextEditingController(text: 'Muanza');

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => widget.backable != null ? widget.backable! : true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 34, 1)),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
            // height: hauteur,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Entete(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Champ(
                    labelText: "Numéro de téléphone",
                    controller: numeroController,
                    clavier: TextInputType.phone,
                    key: _numeroFormKey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                  child: Champ(
                    labelText: "Mot de passe",
                    controller: passeController,
                    key: _passeFormKey,
                    isPassword: true,
                  ),
                ),
                Bouton(
                  largeur: 200,
                  nom: "Se connecter",
                  action: () {
                    getUtilisateur();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 32),
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
                                    builder: (context) =>
                                        InscriptionChoixPage(),
                                  ),
                                );
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      return utilisateur;
    } on Exception catch (e) {
      print("Quelles sont les erreurs");
      print(e);
      throw AuthException("Login ou mot de passe incorrect");
    }
  }
}

class Entete extends StatelessWidget {
  const Entete({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Connexion",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 150,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor ed gravida nunc.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
