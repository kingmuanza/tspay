import 'package:flutter/material.dart';
import 'package:tspay/compte.page.dart';
import 'package:tspay/generer.page.dart';
import 'package:tspay/pay.page.dart';
import 'package:tspay/porte.monnaie.page.dart';

import 'accueil.page.dart';

class MaPage extends StatefulWidget {
  final Widget child;
  final int index;
  const MaPage({Key? key, required this.child, required this.index})
      : super(key: key);

  @override
  _MaPageState createState() => _MaPageState();
}

class _MaPageState extends State<MaPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: widget.child),
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
                    actif: widget.index == 0,
                    page: AccueilPage(),
                  ),
                  TsTab(
                    icone: Icons.add,
                    caractere: "+",
                    nom: "Générer",
                    actif: widget.index == 1,
                    page: GenererPage(),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: BoutonMilieu(
                      actif: widget.index == 2,
                    ),
                  ),
                  TsTab(
                    icone: Icons.credit_card,
                    nom: "Portes Monnaies",
                    actif: widget.index == 3,
                    page: PorteMonnaiePage(),
                  ),
                  TsTab(
                    icone: Icons.person,
                    nom: "Compte",
                    actif: widget.index == 4,
                    page: ComptePage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoutonMilieu extends StatefulWidget {
  final bool actif;
  const BoutonMilieu({Key? key, required this.actif}) : super(key: key);

  @override
  _BoutonMilieuState createState() => _BoutonMilieuState();
}

class _BoutonMilieuState extends State<BoutonMilieu> {
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          _createRoute(PayPage()),
        );
      },
      child: Container(
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
            color: widget.actif
                ? Color.fromRGBO(0, 0, 34, 1)
                : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: Text(
            "PAY",
            style: TextStyle(
              color: widget.actif ? Colors.white : Color.fromRGBO(0, 0, 34, 1),
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          )),
        ),
      ),
    );
  }
}

class TsTab extends StatefulWidget {
  final IconData icone;
  final String nom;
  final bool actif;
  final Widget page;
  String? caractere;

  TsTab(
      {Key? key,
      required this.icone,
      required this.nom,
      required this.page,
      this.caractere,
      required this.actif})
      : super(key: key);

  @override
  _TsTabState createState() => _TsTabState();
}

class _TsTabState extends State<TsTab> {
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        print("on tap");
        print(widget.icone);
        print(widget.nom);

        Navigator.push(
          context,
          _createRoute(widget.page),
        );
      },
      child: Container(
        width: (largeur - 100) / 4,
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            widget.caractere != null
                ? Text(
                    widget.caractere!,
                    style: TextStyle(
                      color: widget.actif ? Colors.grey.shade500 : Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      height: 0.88,
                    ),
                  )
                : Icon(
                    widget.icone,
                    color: widget.actif ? Colors.grey.shade500 : Colors.white,
                    size: 30,
                  ),
            Text(
              widget.nom.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
