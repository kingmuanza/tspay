import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Champ extends StatefulWidget {
  Champ({
    Key? key,
    required this.labelText,
    required this.controller,
    this.formKey,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  GlobalKey<FormState>? formKey;

  @override
  _ChampState createState() => _ChampState();
}

class _ChampState extends State<Champ> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        style: TextStyle(fontSize: 20, color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.always,
        controller: widget.controller,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white70,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
