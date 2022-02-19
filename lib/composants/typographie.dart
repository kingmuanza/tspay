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
          fontSize: 26,
        ),
      ),
    );
  }

  static Widget appTitre(String libelle) {
    return Container(
      width: double.infinity,
      child: Text(
        libelle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  static Widget appSousTitre(String libelle) {
    return Container(
      width: double.infinity,
      child: Text(
        libelle,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
    );
  }

  static Widget titre2(String libelle) {
    return Container(
      width: double.infinity,
      child: Text(
        libelle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w100,
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
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
      ),
    );
  }
}
