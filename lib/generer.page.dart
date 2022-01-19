import 'package:flutter/material.dart';
import 'package:tspay/page.dart';

class GenererPage extends StatefulWidget {
  const GenererPage({Key? key}) : super(key: key);

  @override
  _GenererPageState createState() => _GenererPageState();
}

class _GenererPageState extends State<GenererPage> {
  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Text(
        "Gérérer Code",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 1);
  }
}
