import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/page.dart';
import 'package:tspay/porte.monnaie.code.page.dart';
import 'package:tspay/services/qrcode.service.dart';

import 'composants/champ.dart';

class PorteMonnaiePageAjout extends StatefulWidget {
  const PorteMonnaiePageAjout({Key? key}) : super(key: key);

  @override
  _PorteMonnaiePageAjoutState createState() => _PorteMonnaiePageAjoutState();
}

class _PorteMonnaiePageAjoutState extends State<PorteMonnaiePageAjout> {
  final _numeroFormKey = GlobalKey<FormState>();
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  TextEditingController numeroController =
      TextEditingController(text: '6 76 54 34 95');

  String operateur = "";

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
                  onChanged: (value) {
                    QRCodeService qrCodeService = QRCodeService();
                    String numero = value
                        .toString()
                        .split(' ')
                        .join('')
                        .split('-')
                        .join('');
                    if (numero.length > 3) {
                      operateur = qrCodeService.detecterOperateurMobile(numero);
                      setState(() {});
                    }
                  },
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
                showAlertDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    double largeur = MediaQuery.of(context).size.width;
    Widget okButton = Padding(
      padding: EdgeInsets.only(bottom: 32),
      child: PetitBouton(
        largeur: double.infinity,
        nom: "J'ai compris",
        secondaire: true,
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PorteMonnaieCodePage(),
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
