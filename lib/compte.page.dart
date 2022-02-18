import 'package:flutter/material.dart';
import 'package:tspay/page.dart';
import 'package:tspay/services/utilisateur.service.dart';
import 'package:tspay/vendeur.ajouter.page.dart';

import 'composants/bouton.dart';
import 'connexion.page.dart';
import 'historique.transactions.page.dart';
import 'models/utilisateur.model.dart';

class ComptePage extends StatefulWidget {
  const ComptePage({Key? key}) : super(key: key);

  @override
  _ComptePageState createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {
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

  Widget premiereLigne() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(child: infosPersonnelles()),
          ),
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.topRight,
            // color: Colors.red,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.white,
                size: 30,
              ),
              padding: EdgeInsets.only(top: 5),
              constraints: BoxConstraints(),
            ),
          )
        ],
      ),
    );
  }

  Widget premiereLignePro() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: infosPro(),
            ),
          ),
        ],
      ),
    );
  }

  Widget infosPersonnelles() {
    return Container(
      height: 50,
      // color: Colors.blue,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "Mon compte",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Statut du compte",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infosPro() {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "Compte",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              utilisateur!.commerce != null
                  ? utilisateur!.commerce!
                  : "Utilisateur particulier",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 24,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          premiereLigne(),
          monID(),
          description(),
          Container(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 200,
              child: Bouton(
                  largeur: 200,
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
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget description() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Column(
        children: [
          ligne(),
          Container(
            width: double.infinity,
            child: Text(
              (utilisateur!.noms != null ? utilisateur!.noms! : "Aucun") +
                  " " +
                  (utilisateur!.prenoms != null
                      ? utilisateur!.prenoms!
                      : "utilisateur"),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Né le " +
                  (utilisateur!.datenaiss != null
                      ? utilisateur!.datenaiss!.toIso8601String().split("T")[0]
                      : "Aucune date de naissance"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Tel :  " +
                  (utilisateur!.tel != null
                      ? utilisateur!.tel!
                      : "Aucun numéro de tel"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              utilisateur!.commerce != null
                  ? utilisateur!.commerce!
                  : "Utilisateur particulier",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('Historique');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoriqueTransactionsPage(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              width: double.infinity,
              child: Text(
                "Historique des transactions",
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

  Widget monID() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "IDAUJHD545SNNF88855",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.copy,
            color: Colors.white,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget contenuPro() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          premiereLignePro(),
          monID(),
          description(),
          ajouter(),
          Container(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 200,
              child: Bouton(
                  largeur: 200,
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
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget ligne() {
    return Container(
      height: 1,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
    );
  }

  Widget ajouter() {
    return Column(
      children: [
        ligne(),
        InkWell(
          onTap: () {
            print('Historique');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VendeurAjouterPage(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 16, bottom: 32),
            width: double.infinity,
            child: Text(
              "Ajouter un vendeur",
              style: TextStyle(
                shadows: [Shadow(color: Colors.white, offset: Offset(0, -8))],
                color: Colors.transparent,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
                decorationThickness: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(
        child: utilisateur!.commerce != null ? contenuPro() : contenu(),
        index: 4);
  }
}
