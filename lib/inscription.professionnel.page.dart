import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/connexion.page.dart';
import 'package:tspay/password.page.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';
import 'models/utilisateur.model.dart';

class InscriptionProfessionnelPage extends StatefulWidget {
  const InscriptionProfessionnelPage({Key? key}) : super(key: key);

  @override
  _InscriptionProfessionnelPageState createState() =>
      _InscriptionProfessionnelPageState();
}

class _InscriptionProfessionnelPageState
    extends State<InscriptionProfessionnelPage> {
  final LocalStorage storage = new LocalStorage('tspay');
  final utilisateursFirebase =
      FirebaseFirestore.instance.collection('utilisateurs');
  final _commerceFormKey = GlobalKey<FormState>();
  final _numeroFormKey = GlobalKey<FormState>();
  final _datenaissFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _nomFormKey = GlobalKey<FormState>();
  final _prenomFormKey = GlobalKey<FormState>();
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  TextEditingController commerceController =
      TextEditingController(text: 'Mon commerce');
  TextEditingController numeroController =
      TextEditingController(text: '674750721');
  TextEditingController datenaissController = TextEditingController(text: '');
  TextEditingController nomController = TextEditingController(text: 'Samuel');
  TextEditingController prenomController = TextEditingController(text: "Eto'o");
  TextEditingController emailController =
      TextEditingController(text: 'muanza.kangudie@gmail.com');

  bool checkedValue = false;

  DateTime selectedDate = DateTime.now();

  bool showMessageConditionsUtilisation = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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
                child: EntetePro(),
              ),
              Champ(
                labelText: 'Nom du commerce',
                formKey: _commerceFormKey,
                controller: commerceController,
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
                padding: const EdgeInsets.only(top: 16.0),
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

  onFormSubmit() async {
    if (_datenaissFormKey.currentState!.validate() &&
        _emailFormKey.currentState!.validate() &&
        _nomFormKey.currentState!.validate() &&
        _numeroFormKey.currentState!.validate() &&
        _commerceFormKey.currentState!.validate() &&
        checkedValue) {
      String noms = nomController.text;
      String prenoms = prenomController.text;
      String email = emailController.text;
      String tel = numeroController.text;
      String commerce = commerceController.text;

      Utilisateur utilisateur = Utilisateur(tel);
      utilisateur.noms = noms;
      utilisateur.prenoms = prenoms;
      utilisateur.email = email;
      utilisateur.tel = tel;
      utilisateur.commerce = commerce;

      var resultat = await utilisateursFirebase.doc(utilisateur.id!).get();
      var u = resultat.data();
      print("utilisatuer trouvé");
      print(u);
      if (u != null) {
        showAlertDialog(context);
      } else {
        storage.setItem("utilisateur", utilisateur.toMap()).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordPage(),
            ),
          );
        });
      }
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
    Widget okButton = Padding(
      padding: EdgeInsets.only(bottom: 32),
      child: PetitBouton(
        largeur: 100,
        nom: "Me connecter",
        secondaire: true,
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConnexionPage(),
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
      title: Text("Compte existant"),
      content: Text(
          "Un compte a déjà été crée avec ce numéro, s'il s'agit de vous. Veuillez-vous connecter !"),
      actions: [okButton, fermerButton],
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

class EntetePro extends StatelessWidget {
  const EntetePro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Inscription",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Nullam eget sodales nulla, sed gravida nunc. Suspendisse potenti. Morbi vel nulla tortor.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
