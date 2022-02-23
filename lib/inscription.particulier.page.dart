import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/inscription.code.page.dart';
import 'package:tspay/password.page.dart';
import 'package:http/http.dart' as http;

import 'composants/bouton.dart';
import 'composants/champ.dart';
import 'models/utilisateur.model.dart';
import 'services/utilisateur.service.dart';

class InscriptionParticulierPage extends StatefulWidget {
  const InscriptionParticulierPage({Key? key}) : super(key: key);

  @override
  _InscriptionParticulierPageState createState() =>
      _InscriptionParticulierPageState();
}

class _InscriptionParticulierPageState
    extends State<InscriptionParticulierPage> {
  final LocalStorage storage = new LocalStorage('tspay');
  final _parrainFormKey = GlobalKey<FormState>();
  final _numeroFormKey = GlobalKey<FormState>();
  final _datenaissFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _nomFormKey = GlobalKey<FormState>();
  final _prenomFormKey = GlobalKey<FormState>();
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  TextEditingController numeroController =
      TextEditingController(text: '6 96 54 34 95');
  TextEditingController parrainController = TextEditingController(text: '');
  TextEditingController datenaissController = TextEditingController(text: '');
  TextEditingController nomController = TextEditingController(text: 'Muanza');
  TextEditingController prenomController =
      TextEditingController(text: 'Kangudie');
  TextEditingController emailController =
      TextEditingController(text: 'muanza.kangudie@gmail.com');

  bool checkedValue = false;

  DateTime selectedDate = DateTime.now().subtract(Duration(days: 365 * 18));

  bool showMessageConditionsUtilisation = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 8),
      lastDate: DateTime.now().subtract(Duration(days: 365 * 18)),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        datenaissController.text = picked.toIso8601String().split('T')[0];
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    String labelText = "Noms";
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 34, 1)),
        padding: EdgeInsets.only(left: 32, right: 32, top: 0),
        height: hauteur,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 16),
                child: Column(
                  children: [
                    Typographie.titre("Inscription"),
                    Typographie.sousTitre(
                        "Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor."),
                  ],
                ),
              ),
              Champ(
                labelText: 'Noms',
                formKey: _nomFormKey,
                controller: nomController,
              ),
              Champ(
                labelText: 'Prénoms',
                formKey: _prenomFormKey,
                controller: prenomController,
              ),
              Champ(
                labelText: 'Email',
                formKey: _emailFormKey,
                controller: emailController,
                clavier: TextInputType.emailAddress,
              ),
              Champ(
                labelText: 'Date de naissance',
                formKey: _datenaissFormKey,
                controller: datenaissController,
                clavier: TextInputType.datetime,
                readOnly: true,
                iconeBouton: IconButton(
                  icon: Icon(
                    Icons.calendar_today_sharp,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
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
                      labelText: 'Numéro de téléphone',
                      formKey: _numeroFormKey,
                      controller: numeroController,
                      clavier: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              Champ(
                labelText: 'ID du parrain',
                formKey: _parrainFormKey,
                controller: parrainController,
                validator: (value) {
                  return null;
                },
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: CheckboxListTile(
                  title: Text(
                    "J'accepte les conditions d'utilisation",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(0),
                  value: checkedValue,
                  activeColor: Colors.white,
                  checkColor: Colors.white,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              showMessageConditionsUtilisation
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Veuillez accepter les conditions d'utilisation",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 32),
                child: Bouton(
                  nom: "S'inscrire",
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

  onFormSubmit() async {
    if (_datenaissFormKey.currentState!.validate() &&
        _emailFormKey.currentState!.validate() &&
        _nomFormKey.currentState!.validate() &&
        _numeroFormKey.currentState!.validate() &&
        _parrainFormKey.currentState!.validate() &&
        checkedValue) {
      String noms = nomController.text;
      String prenoms = prenomController.text;
      String email = emailController.text;
      String tel = numeroController.text;
      String idparrain = parrainController.text;

      Utilisateur utilisateur = Utilisateur(tel);
      utilisateur.noms = noms;
      utilisateur.prenoms = prenoms;
      utilisateur.email = email;
      utilisateur.tel = tel;
      utilisateur.idparrain = idparrain;
      utilisateur.datenaiss = selectedDate;
      print(utilisateur.toMap());
      UtilisateurService utilisateurService = UtilisateurService();
      utilisateurService.getFirebaseUtilisateur(utilisateur.id!).then((u) {
        print("utilisatuer trouvé : " + utilisateur.id!);
        print(u);
        this.showAlertDialog(context);
      }).catchError((e) {
        utilisateurService.setLocalUtilisateur(utilisateur).then((value) {
          String codeEnvoyee = generateCode();
          sendSMSviaAPI(codeEnvoyee, utilisateur.id!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InscriptionCodePage(
                code: codeEnvoyee,
              ),
            ),
          );
        });
      });
    } else {
      if (!checkedValue) {
        showMessageConditionsUtilisation = true;
        setState(() {
          showMessageConditionsUtilisation = true;
        });
      } else {
        showMessageConditionsUtilisation = false;
        setState(() {
          showMessageConditionsUtilisation = false;
        });
      }
    }
  }

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
        action: () {
          Navigator.pop(context);
        },
      ),
    );
    Widget fermerButton = Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Bouton(
        largeur: double.infinity,
        nom: "Fermer",
        action: () {
          Navigator.pop(context);
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Compte existant"),
      content: Text(
          "Un compte a déjà été crée avec ce numéro, s'il s'agit de vous. Veuillez-vous connecter !"),
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
}
