import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Champ extends StatefulWidget {
  Champ({
    Key? key,
    required this.labelText,
    required this.controller,
    this.formKey,
    this.clavier,
    this.iconeBouton,
    this.readOnly,
    this.validator,
    this.onChanged,
    this.isPassword,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  GlobalKey<FormState>? formKey;
  TextInputType? clavier;
  IconButton? iconeBouton;
  bool? readOnly;
  bool? isPassword;
  String? Function(dynamic)? validator;
  String? Function(dynamic)? onChanged;

  @override
  _ChampState createState() => _ChampState();
}

class _ChampState extends State<Champ> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: TextFormField(
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        style: TextStyle(fontSize: 16, color: Colors.white),
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          if (value == null || value.isEmpty) {
            return 'Champ obligatoire';
          }
          return null;
        },
        obscureText: widget.isPassword != null ? widget.isPassword! : false,
        keyboardType:
            widget.clavier != null ? widget.clavier : TextInputType.text,
        autovalidateMode: AutovalidateMode.always,
        controller: widget.controller,
        cursorColor: Colors.white,
        // enabled: false,
        readOnly: widget.readOnly != null ? widget.readOnly! : false,
        decoration: InputDecoration(
          suffixIcon: widget.iconeBouton,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontSize: 16.0,
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
