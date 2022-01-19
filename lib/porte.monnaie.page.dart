import 'package:flutter/material.dart';
import 'package:tspay/page.dart';

class PorteMonnaiePage extends StatefulWidget {
  const PorteMonnaiePage({Key? key}) : super(key: key);

  @override
  _PorteMonnaiePageState createState() => _PorteMonnaiePageState();
}

class _PorteMonnaiePageState extends State<PorteMonnaiePage> {
  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Text(
        "Portes monnaies",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 3);
  }
}
