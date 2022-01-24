import 'package:flutter/material.dart';
import 'package:tspay/composants/bouton.dart';
import 'package:tspay/composants/champ.dart';
import 'package:tspay/generer.qrcode.page.dart';
import 'package:tspay/page.dart';

class GenererPage extends StatefulWidget {
  const GenererPage({Key? key}) : super(key: key);

  @override
  _GenererPageState createState() => _GenererPageState();
}

class _GenererPageState extends State<GenererPage> {
  TextEditingController montantController =
      TextEditingController(text: '100000');

  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32),
            width: double.infinity,
            child: Text(
              "Gérérer un paiement",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            child: Champ(
              labelText: "Montant du paiement",
              controller: montantController,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Bouton(
              largeur: 120,
              nom: "Continuer",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenererQRCodePage(
                      montant: int.parse(montantController.text),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 1);
  }
}
