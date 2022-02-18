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
}
