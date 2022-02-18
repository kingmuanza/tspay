import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Typographie {
  static Widget titre(String libelle) {
    return Container(
      width: double.infinity,
      child: Text(
        libelle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }

  static Widget logo([double? taille]) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            height: taille != null ? taille : 100,
          ),
        ),
      ),
    );
  }

  static Widget sousTitre(String libelle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Text(
        libelle,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
