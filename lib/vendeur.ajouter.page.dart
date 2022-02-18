import 'package:flutter/material.dart';
import 'package:tspay/page.dart';
import 'package:tspay/services/utilisateur.service.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';
import 'models/utilisateur.model.dart';

class VendeurAjouterPage extends StatefulWidget {
  const VendeurAjouterPage({Key? key}) : super(key: key);

  @override
  _VendeurAjouterPageState createState() => _VendeurAjouterPageState();
}

class _VendeurAjouterPageState extends State<VendeurAjouterPage> {
  UtilisateurService utilisateurService = UtilisateurService();
  Utilisateur? utilisateur = Utilisateur("");

  final _passeFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  final _confirmFormKey = GlobalKey<FormState>();
  final _nomFormKey = GlobalKey<FormState>();
  final _prenomFormKey = GlobalKey<FormState>();

  TextEditingController passeController = TextEditingController(text: 'Muanza');
  TextEditingController loginController = TextEditingController(text: 'Muanza');
  TextEditingController nomController = TextEditingController(text: 'Muanza');
  TextEditingController prenomController =
      TextEditingController(text: 'Kangudie');
  TextEditingController confirmController =
      TextEditingController(text: 'muanza.kangudie@gmail.com');

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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: double.infinity,
          child: Text(
            "Ajouter un vendeur",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4, bottom: 8),
          width: double.infinity,
          child: Text(
            utilisateur!.commerce != null
                ? utilisateur!.commerce!
                : "Utilisateur particulier",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        Champ(
          labelText: 'Login',
          formKey: _loginFormKey,
          controller: loginController,
        ),
        Champ(
          labelText: 'Passe',
          formKey: _passeFormKey,
          controller: passeController,
          isPassword: true,
        ),
        Champ(
          labelText: 'Confirmer le mot de passe',
          formKey: _confirmFormKey,
          controller: confirmController,
          isPassword: true,
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
        Container(
          padding: const EdgeInsets.only(top: 24),
          alignment: Alignment.topLeft,
          child: Bouton(
            nom: "Ajouter",
            largeur: 200,
            action: () {
              //onFormSubmit();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 4);
  }
}
