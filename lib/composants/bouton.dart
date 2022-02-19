import 'package:flutter/material.dart';

class Bouton extends StatefulWidget {
  final double largeur;
  final String nom;
  final Function action;
  bool? secondaire;

  Bouton({
    Key? key,
    required this.largeur,
    required this.nom,
    required this.action,
    bool? this.secondaire,
  }) : super(key: key);

  @override
  _BoutonState createState() => _BoutonState();
}

class _BoutonState extends State<Bouton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.action();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.secondaire != null
              ? Color.fromRGBO(0, 0, 34, 1)
              : Colors.transparent,
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            widget.largeur,
            45,
          ),
        ),
        shape: widget.secondaire != null
            ? MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                    color: Colors.white,
                    width: 0.0,
                  ),
                ),
              )
            : MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
      ),
      child: Text(
        widget.nom.toUpperCase(),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class GrosBouton extends StatefulWidget {
  final String titre;
  final String contenu;
  final Function action;

  const GrosBouton({
    Key? key,
    required this.titre,
    required this.contenu,
    required this.action,
  }) : super(key: key);

  @override
  _GrosBoutonState createState() => _GrosBoutonState();
}

class _GrosBoutonState extends State<GrosBouton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.action();
      },
      child: Container(
        width: double.infinity,
        height: 120,
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 140,
              child: Text(
                widget.titre,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 16),
              child: Text(
                widget.contenu,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PetitBouton extends StatefulWidget {
  final double largeur;
  final String nom;
  final Function action;
  bool? secondaire;
  PetitBouton({
    Key? key,
    required this.largeur,
    required this.nom,
    required this.action,
    bool? this.secondaire,
  }) : super(key: key);

  @override
  _PetitBoutonState createState() => _PetitBoutonState();
}

class _PetitBoutonState extends State<PetitBouton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.action();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.secondaire != null
              ? Color.fromRGBO(0, 0, 34, 1)
              : Colors.white,
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            widget.largeur,
            40,
          ),
        ),
        shape: widget.secondaire != null
            ? MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                    color: Colors.white,
                    width: 0.0,
                  ),
                ),
              )
            : MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                    color: Color.fromRGBO(0, 0, 34, 1),
                    width: 2.0,
                  ),
                ),
              ),
      ),
      child: Text(
        widget.nom.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          color: widget.secondaire != null
              ? Colors.white
              : Color.fromRGBO(0, 0, 34, 1),
        ),
      ),
    );
  }
}
