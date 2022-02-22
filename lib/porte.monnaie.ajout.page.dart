import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/models/porte.monnaie.model.dart';
import 'package:tspay/page.dart';
import 'package:tspay/porte.monnaie.code.page.dart';
import 'package:tspay/services/porte.monnaie.service.dart';
import 'package:tspay/services/qrcode.service.dart';
import 'package:tspay/services/utilisateur.service.dart';
import 'dart:math';
import 'composants/champ.dart';
import 'models/utilisateur.model.dart';
import 'package:localstorage/localstorage.dart';

import 'package:http/http.dart' as http;

class PorteMonnaiePageAjout extends StatefulWidget {
  const PorteMonnaiePageAjout({Key? key}) : super(key: key);

  @override
  _PorteMonnaiePageAjoutState createState() => _PorteMonnaiePageAjoutState();
}

class _PorteMonnaiePageAjoutState extends State<PorteMonnaiePageAjout> {
  final _numeroFormKey = GlobalKey<FormState>();
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  TextEditingController numeroController = TextEditingController(text: '6');

  String operateur = "";
  UtilisateurService utilisateurService = UtilisateurService();
  Utilisateur? utilisateur = Utilisateur("");

  final LocalStorage storage = new LocalStorage('tspay');

  @override
  initState() {
    super.initState();
    this.init();
  }

  init() async {
    utilisateur = await utilisateurService.getLocalUtilisateur();
    setState(() {});
  }

  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            child:
                Typographie.appTitre("Ajouter un porte-monnaie électronique"),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 16),
            child: Typographie.appSousTitre(
                "Aenean metus metus, fringilla id nisl ut, laoreet interdum eros. Suspendisse potenti. Morbi vel nulla tortor"),
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
                child: Form(
                  child: Champ(
                    labelText: 'Numéro de téléphone',
                    formKey: _numeroFormKey,
                    controller: numeroController,
                    clavier: TextInputType.phone,
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

                      if (utilisateur!.id! == "237" + value) {
                        return "Le porte-monnaie est déjà présent";
                      }
                    },
                    onChanged: (value) {
                      QRCodeService qrCodeService = QRCodeService();
                      String numero = value
                          .toString()
                          .split(' ')
                          .join('')
                          .split('-')
                          .join('');
                      if (numero.length > 3) {
                        operateur =
                            qrCodeService.detecterOperateurMobile(numero);
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              operateur,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 32),
            child: Bouton(
              largeur: 200,
              nom: "Ajouter",
              action: () {
                if (_numeroFormKey.currentState!.validate()) {
                  PorteMonnaie porteMonnaie = PorteMonnaie();
                  porteMonnaie.idutilisateur = utilisateur!.id!;
                  porteMonnaie.numero = numeroController.text;
                  PorteMonnaieService porteMonnaieService =
                      PorteMonnaieService();
                  porteMonnaieService
                      .setFirebasePorteMonnaie(porteMonnaie)
                      .then((value) {
                    if (value) {
                      showAlertDialog(context, porteMonnaie);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Le porte monnaie existe déjà")),
                      );
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
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

  sendSMSviaAPI(String codeEnvoyee) async {
    var code = codeEnvoyee;
    var numero = utilisateur!.id!;

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

  showAlertDialog(BuildContext context, PorteMonnaie porteMonnaie) {
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
          sendSMSviaAPI(codeEnvoyee);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PorteMonnaieCodePage(
                porteMonnaie: porteMonnaie,
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
    return MaPage(
      child: contenu(),
      index: 3,
      backable: true,
    );
  }
}
