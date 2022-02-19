import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tspay/models/paiement.model.dart';

class QRCodeService {
  final LocalStorage storage = new LocalStorage('tspay');
  final paiementsFirebase = FirebaseFirestore.instance.collection('paiements');

  creer(Paiement paiement) async {
    await paiementsFirebase.doc(paiement.id).set(paiement.toMap());
    print("Paiement créé " + paiement.id!);
  }

  save(Paiement paiement) async {
    await paiementsFirebase.doc(paiement.id).set(paiement.toMap());
    print("Paiement mis à jour " + paiement.id!);
  }

  Future<Paiement?> recuperer(String idpaiement) async {
    DocumentSnapshot resultat = await paiementsFirebase.doc(idpaiement).get();
    Map<String, dynamic>? donnees = resultat.data();
    if (donnees != null) {
      Paiement paiement = Paiement.fromMap(donnees);
      print("Paiement recupereé " + paiement.id!);
      return paiement;
    } else {
      print("Aucun Paiement trouvé ");
      return null;
    }
  }

  Future<List<Paiement>> paiementsRecus(String idutilisateur) async {
    print("idutilisateur");
    print(idutilisateur);
    List<Paiement> paiements = [];
    QuerySnapshot resultats = await paiementsFirebase
        .where("idutilisateur", isEqualTo: idutilisateur)
        .get();
    print("tout se passe bien");
    for (var resultat in resultats.docs) {
      Map<String, dynamic>? donnees = resultat.data();
      Paiement paiement = Paiement.fromMap(donnees);
      paiements.add(paiement);
    }
    print("tout s'est bien passé");
    print(paiements.length);
    return paiements;
  }

  Future<List<Paiement>> paiementsEmis(String idutilisateur) async {
    print("idutilisateur");
    print(idutilisateur);
    List<Paiement> paiements = [];
    QuerySnapshot resultats = await paiementsFirebase
        .where("idpayeur", isEqualTo: idutilisateur)
        .get();
    print("tout se passe bien");
    for (var resultat in resultats.docs) {
      Map<String, dynamic>? donnees = resultat.data();
      Paiement paiement = Paiement.fromMap(donnees);
      paiements.add(paiement);
    }
    print("tout s'est bien passé");
    print(paiements.length);
    return paiements;
  }

  Future<List<Paiement>> historique(String idutilisateur) async {
    print("historique");
    print(historique);
    List<Paiement> paiements = [];
    List<Paiement> paiementsR = await paiementsEmis(idutilisateur);
    List<Paiement> paiementsE = await paiementsRecus(idutilisateur);

    paiements.addAll(paiementsR);
    paiements.addAll(paiementsE);

    paiements.sort((a, b) {
      return a.dateGeneration!.millisecondsSinceEpoch -
          b.dateGeneration!.millisecondsSinceEpoch;
    });

    print("paiements");
    print(paiements.length);
    return paiements;
  }
}
