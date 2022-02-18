import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/exceptions/auth.exception.dart';
import 'package:tspay/models/utilisateur.model.dart';

class UtilisateurService {
  final LocalStorage storage = new LocalStorage('tspay');
  final utilisateursFirebase =
      FirebaseFirestore.instance.collection('utilisateurs');

  Future<Utilisateur> connexion(String id, String passe) async {
    print('Connexion');
    print(id);
    print('237' + id);
    var resultat = await utilisateursFirebase.doc('237' + id).get();
    print('fin firebase');
    print(resultat);
    print(resultat.data());
    var u = resultat.data();
    if (u != null) {
      print('utilisateur troubvé');
      Utilisateur utilisateur = Utilisateur.fromMap(u);
      if (utilisateur.passe != null) {
        var passwordHachee = utilisateur.passe;
        print(passwordHachee);
        print(passe);
        print(utilisateur.noms);
        print(utilisateur.prenoms);
        var result =
            await FlutterBcrypt.verify(password: passe, hash: passwordHachee!);
        print("result: " + (result ? "ok" : "nok"));
        if (!result) {
          throw AuthException("Mot de passe incorrect");
        } else {
          await storage.setItem('utilisateur', u);
          return utilisateur;
        }
      } else {
        throw AuthException("Aucun mot de passe fourni");
      }
    } else {
      throw AuthException("Aucun utilisateur trouvé");
    }
  }

  Future<Utilisateur?> getLocalUtilisateur() async {
    Map<String, dynamic> utilisateurMap = await storage.getItem('utilisateur');
    if (utilisateurMap != null) {
      return Utilisateur.fromMap(utilisateurMap);
    } else {
      return null;
    }
  }

  Future<Utilisateur> getFirebaseUtilisateur(String id) async {
    var resultat = await utilisateursFirebase.doc('237' + id).get();
    var u = resultat.data();
    if (u != null) {
      Utilisateur utilisateur = Utilisateur.fromMap(u);
      return utilisateur;
    } else {
      throw "Aucun utilisateur trouvé";
    }
  }
}
