import 'package:flutter/material.dart';
import 'package:tspay/composants/typographie.dart';
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
              onPressed: () {
                print("showModalBottomSheet");
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                'Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit',
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 32.0,
                                ),
                                child: Bouton(
                                    largeur: 200,
                                    nom: "Déconnexion",
                                    secondaire: true,
                                    action: () {
                                      Navigator.pop(context);
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
                            ],
                          ),
                        ),
                      );
                    });
              },
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Typographie.appTitre("Compte"),
                Typographie.appSousTitre(utilisateur!.commerce != null
                    ? utilisateur!.commerce!
                    : "Utilisateur particulier"),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.topRight,
            // color: Colors.red,
            child: IconButton(
              onPressed: () {
                print("showModalBottomSheet");
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                'Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit',
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 32.0,
                                ),
                                child: Bouton(
                                    largeur: 200,
                                    nom: "Déconnexion",
                                    secondaire: true,
                                    action: () {
                                      Navigator.pop(context);
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
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.white,
                size: 30,
              ),
              padding: EdgeInsets.only(top: 5),
              constraints: BoxConstraints(),
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: monID(),
          ),
          description(),
        ],
      ),
    );
  }

  Widget description() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoriqueTransactionsPage(
              utilisateur: utilisateur!,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: 8,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
        ),
        child: Column(
          children: [
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
                        ? utilisateur!.datenaiss!
                            .toIso8601String()
                            .split("T")[0]
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
            )
          ],
        ),
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: monID(),
          ),
          description(),
          Container(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: double.infinity,
              child: Bouton(
                  largeur: double.infinity,
                  nom: "Ajouter un vendeur",
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
          ),
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

  @override
  Widget build(BuildContext context) {
    return MaPage(
        child: utilisateur!.commerce != null ? contenuPro() : contenu(),
        index: 4);
  }
}
