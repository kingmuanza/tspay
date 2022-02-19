import 'package:flutter/material.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/page.dart';
import 'package:tspay/porte.monnaie.ajout.page.dart';
import 'package:tspay/porte.monnaie.voir.page.dart';
import 'package:tspay/services/qrcode.service.dart';

import 'models/utilisateur.model.dart';
import 'services/utilisateur.service.dart';

class PorteMonnaiePage extends StatefulWidget {
  const PorteMonnaiePage({Key? key}) : super(key: key);

  @override
  _PorteMonnaiePageState createState() => _PorteMonnaiePageState();
}

class _PorteMonnaiePageState extends State<PorteMonnaiePage> {
  UtilisateurService utilisateurService = UtilisateurService();
  Utilisateur? utilisateur = Utilisateur("");

  @override
  initState() {
    super.initState();
    this.init();
  }

  init() async {
    utilisateur = await utilisateurService.getLocalUtilisateur();
    setState(() {});
  }

  String detecterOperateurMobile(String numero) {
    QRCodeService qrCodeService = QRCodeService();
    return qrCodeService.detecterOperateurMobile(numero);
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
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 16),
            child: Typographie.appTitre("Mes portes-monnaies électroniques"),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Typographie.sousTitre(
                "Aenean metus metus, fringilla id nisl ut, laoreet interdum eros. Suspendisse potenti. Morbi vel nulla tortor"),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PorteMonnaieVoirPage(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: Box(
                detecterOperateurMobile(utilisateur!.tel!),
                utilisateur!.tel!,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 32),
            child: TextButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PorteMonnaiePageAjout(),
                  ),
                )
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                alignment: Alignment.topLeft,
              ),
              child: Text(
                "Ajouter un porte-monnaie",
                style: TextStyle(
                  shadows: [Shadow(color: Colors.white, offset: Offset(0, -8))],
                  color: Colors.transparent,
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Box(String libelle, String montant, [String? unite]) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 0,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            child: Text(
              libelle,
              // textAlign: unite != null ? TextAlign.left : TextAlign.right,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 4,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            child: setLibelle(montant, unite),
          ),
        ],
      ),
    );
  }

  Widget setLibelle(String montant, String? unite) {
    return RichText(
      // textAlign: unite != null ? TextAlign.left : TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: montant,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
            ),
          ),
          unite != null
              ? TextSpan(
                  text: " " + unite,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 0.1,
                  ),
                )
              : TextSpan(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 3);
  }
}
