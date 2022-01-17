import 'package:flutter/material.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 34, 1),
              ),
              alignment: Alignment.center,
              child: Text(
                "Accueil",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            padding: EdgeInsets.only(top: 0, bottom: 0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 34, 1),
            ),
            child: Wrap(
              children: [
                TsTab(
                  icone: Icons.home_filled,
                  nom: "Accueil",
                ),
                TsTab(
                  icone: Icons.home_filled,
                  nom: "Accueil",
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: BoutonMilieu(),
                ),
                TsTab(
                  icone: Icons.home_filled,
                  nom: "Accueil",
                ),
                TsTab(
                  icone: Icons.home_filled,
                  nom: "Accueil",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoutonMilieu extends StatefulWidget {
  const BoutonMilieu({Key? key}) : super(key: key);

  @override
  _BoutonMilieuState createState() => _BoutonMilieuState();
}

class _BoutonMilieuState extends State<BoutonMilieu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Center(
            child: Text(
          "PAY",
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 34, 1),
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        )),
      ),
    );
  }
}

class TsTab extends StatefulWidget {
  final IconData icone;
  final String nom;
  const TsTab({Key? key, required this.icone, required this.nom})
      : super(key: key);

  @override
  _TsTabState createState() => _TsTabState();
}

class _TsTabState extends State<TsTab> {
  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Container(
      width: (largeur - 100) / 4,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Icon(
            Icons.home_filled,
            color: Colors.white,
            size: 30,
          ),
          Text(
            "Accueil",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
