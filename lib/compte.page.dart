import 'package:flutter/material.dart';
import 'package:tspay/page.dart';

import 'composants/bouton.dart';
import 'connexion.page.dart';

class ComptePage extends StatefulWidget {
  const ComptePage({Key? key}) : super(key: key);

  @override
  _ComptePageState createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {
  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "Muanza Kangudie",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Bouton(
              largeur: 100,
              nom: "Déconnexion",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConnexionPage(
                      backable: false,
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 4);
  }
}
