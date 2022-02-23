import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/connexion.page.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:tspay/password.oublie.code.page.dart';
import 'package:tspay/services/utilisateur.service.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';
import 'models/utilisateur.model.dart';

class PasswordOublieNumeroPage extends StatefulWidget {
  const PasswordOublieNumeroPage({Key? key}) : super(key: key);

  @override
  _PasswordOublieNumeroPageState createState() =>
      _PasswordOublieNumeroPageState();
}

class _PasswordOublieNumeroPageState extends State<PasswordOublieNumeroPage> {
  final LocalStorage storage = new LocalStorage('tspay');
  final utilisateursFirebase =
      FirebaseFirestore.instance.collection('utilisateurs');
  final _passeFormKey = GlobalKey<FormState>();
  final _confirmFormKey = GlobalKey<FormState>();
  final _numeroFormKey = GlobalKey<FormState>();
  TextEditingController numeroController =
      TextEditingController(text: '696543495');
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  Utilisateur utilisateur = new Utilisateur('');

  bool checkedValue = false;

  String generateCode() {
    Random random = new Random();
    int code = random.nextInt(9000) + 1000;
    storage.setItem("tspaycode", code.toString());
    print('tspaycode');
    print(code.toString());
    print('tspaycode');
    print(code.toString());
    print('tspaycode');
    print(code.toString());
    return code.toString();
  }

  sendSMSviaAPI(String codeEnvoyee, String numero) async {
    var code = codeEnvoyee;

    var url = Uri.https('moneytrans.waveslights.com',
        '/administration/sendsms2.php', {'numero': numero, 'code': code});

    try {
      var response = await http.get(url);
      print('FIN de l envoiSMSEtValidation');
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        print(jsonResponse);
      } else {
        print('Request failed with status: ${response.statusCode}.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de l'envoi du SMS")),
        );
      }
    } catch (e) {
      // print(e);
    }
  }

  showAlertDialog(BuildContext context, String numero) {
    // set up the button
    String codeEnvoyee = generateCode();

    double largeur = MediaQuery.of(context).size.width;
    Widget okButton = Padding(
      padding: EdgeInsets.only(bottom: 32),
      child: PetitBouton(
        largeur: double.infinity,
        nom: "J'ai compris",
        secondaire: true,
        action: () {
          sendSMSviaAPI(codeEnvoyee, numero);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordOublieCodePage(
                code: codeEnvoyee,
              ),
            ),
          );
        },
      ),
    );
    Widget fermerButton = Padding(
      padding: EdgeInsets.only(bottom: 32, right: 4),
      child: PetitBouton(
        largeur: 100,
        nom: "Fermer",
        action: () {
          Navigator.pop(context);
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Vous allez recevoir un SMS à ce numéro",
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Aenean metus metus, fringilla id nisl ut, laoreet interdum eros. Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor",
        textAlign: TextAlign.center,
      ),
      actions: [okButton],
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
                child:
                    Typographie.appTitre("Confirmez votre numéro de téléphone"),
              ),
              Row(
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
                      validator: (value) {
                        String numero = value
                            .toString()
                            .split(' ')
                            .join('')
                            .split('-')
                            .join('');
                        if (numero.length != 9) {
                          return "Numéro de téléphone invalide";
                        }
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Bouton(
                  nom: "Confirmer",
                  largeur: largeur / 2,
                  action: () {
                    onFormSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  onFormSubmit() async {
    if (numeroController.text.length == 9) {
      UtilisateurService utilisateurService = UtilisateurService();
      String numero = "237" + numeroController.text;
      String id = numero.toString().split(' ').join('').split('-').join('');
      print("ID à changer");
      print(id);
      utilisateurService.getFirebaseUtilisateur(id).then((value) {
        Map<String, dynamic> utilisateurMap = value.toMap();
        storage.setItem("utilisateur", utilisateurMap);
        showAlertDialog(context, id);
      }).catchError((onError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Aucun utilisateur associé à ce numéro")),
        );
      });
    }
  }
}
