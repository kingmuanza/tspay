import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/accueil.page.dart';
import 'package:tspay/composants/champ.dart';

import 'composants/bouton.dart';
import 'inscription.particulier.page.dart';
import 'models/utilisateur.model.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({Key? key}) : super(key: key);

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
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
    });
  }

  connexion(String id, String passe) async {
    print('Connexion');
    print(id);
    print('237' + id);
    var resultat = await utilisateursFirebase.doc('237' + id).get();
    print('fin firebase');
    print(resultat);
    print(resultat.data());
    var u = resultat.data();
    if (u != null) {
      print('utilisateur troubvé');
      Utilisateur utilisateur = Utilisateur.fromMap(u);
      if (utilisateur.passe != null) {
        var passwordHachee = utilisateur.passe;
        print(passwordHachee);
        print(passe);
        var result =
            await FlutterBcrypt.verify(password: passe, hash: passwordHachee!);
        print("result: " + (result ? "ok" : "nok"));
        if (!result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mot de passe incorrect')),
          );
          throw "Mot de passe incorrect";
        } else {
          storage.setItem('utilisateur', u);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucun utilisateur trouvé')),
      );
      throw "Aucun utilisateur trouvé";
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
