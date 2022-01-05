import 'package:flutter/material.dart';
import 'package:tspay/password.page.dart';

import 'composants/bouton.dart';
import 'composants/champ.dart';

class InscriptionFormulairePage extends StatefulWidget {
  const InscriptionFormulairePage({Key? key}) : super(key: key);

  @override
  _InscriptionFormulairePageState createState() =>
      _InscriptionFormulairePageState();
}

class _InscriptionFormulairePageState extends State<InscriptionFormulairePage> {
  final _parrainFormKey = GlobalKey<FormState>();
  final _numeroFormKey = GlobalKey<FormState>();
  final _datenaissFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _nomFormKey = GlobalKey<FormState>();
  final _prenomFormKey = GlobalKey<FormState>();
  TextEditingController indicatifController =
      TextEditingController(text: '+237');
  TextEditingController parrainController = TextEditingController(text: '');
  TextEditingController numeroController = TextEditingController(text: '6 ');
  TextEditingController datenaissController = TextEditingController(text: '');
  TextEditingController nomController = TextEditingController(text: 'Muanza');
  TextEditingController prenomController =
      TextEditingController(text: 'Kangudie');
  TextEditingController emailController =
      TextEditingController(text: 'muanza@gmail.com');

  bool checkedValue = false;

  DateTime selectedDate = DateTime.now();

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
                child: EnteteGauche(),
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Bouton(
                  nom: "S'inscrire",
                  largeur: largeur / 2,
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class EnteteGauche extends StatelessWidget {
  const EnteteGauche({
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
