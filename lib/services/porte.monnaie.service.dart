import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/exceptions/auth.exception.dart';
import 'package:tspay/models/porte.monnaie.model.dart';

class PorteMonnaieService {
  final LocalStorage storage = new LocalStorage('tspay');
  final porteMonnaiesFirebase =
      FirebaseFirestore.instance.collection('porteMonnaies');

  Future<PorteMonnaie> get(String id) async {
    print("id");
    print(id);
    var resultat = await porteMonnaiesFirebase.doc(id).get();
    var u = resultat.data();
    if (u != null) {
      PorteMonnaie porteMonnaie = PorteMonnaie.fromMap(u);
      return porteMonnaie;
    } else {
      throw "Aucun porteMonnaie trouvé";
    }
  }

  Future<List<PorteMonnaie>> getAll(String idutilisateur) async {
    print("idutilisateur");
    print(idutilisateur);
    List<PorteMonnaie> porteMonnaies = [];
    QuerySnapshot resultats = await porteMonnaiesFirebase
        .where("idutilisateur", isEqualTo: idutilisateur)
        .get();
    print("tout se passe bien");
    for (var resultat in resultats.docs) {
      Map<String, dynamic>? donnees = resultat.data();
      PorteMonnaie porteMonnaie = PorteMonnaie.fromMap(donnees);
      porteMonnaies.add(porteMonnaie);
    }
    print("tout s'est bien passé");
    print(porteMonnaies.length);
    return porteMonnaies;
  }

  Future<bool> setFirebasePorteMonnaie(PorteMonnaie porteMonnaie) async {
    print("porteMonnaie");
    print(porteMonnaie.toMap());
    QuerySnapshot resultats = await porteMonnaiesFirebase
        .where("numero", isEqualTo: porteMonnaie.numero)
        .get();
    if (resultats.docs.isNotEmpty) {
      return false;
    } else {
      await porteMonnaiesFirebase
          .doc(porteMonnaie.id)
          .set(porteMonnaie.toMap());
      return true;
    }
  }

  Future<bool> supprimer(PorteMonnaie porteMonnaie) async {
    print("porteMonnaie");
    print(porteMonnaie.toMap());

    await porteMonnaiesFirebase.doc(porteMonnaie.id).delete();
    return true;
  }
}
