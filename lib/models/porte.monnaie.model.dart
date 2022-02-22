import 'package:uuid/uuid.dart';

class PorteMonnaie {
  String? id;
  String? idutilisateur;
  String? numero;
  String? statut;
  int montant = 0;

  PorteMonnaie() {
    this.id = generateID();
  }

  generateID() {
    var uuid = Uuid();
    return uuid.v1();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': montant,
      'numero': numero,
      'idutilisateur': idutilisateur,
      'statut': statut,
    };
  }

  factory PorteMonnaie.fromMap(Map<String, dynamic> map) {
    PorteMonnaie pm = PorteMonnaie();

    if (map['id'] != null) {
      pm.id = map['id'];
    }
    if (map['montant'] != null) {
      pm.montant = map['montant'];
    }
    if (map['numero'] != null) {
      pm.numero = map['numero'];
    }
    if (map['idutilisateur'] != null) {
      pm.idutilisateur = map['idutilisateur'];
    }
    if (map['statut'] != null) {
      pm.statut = map['statut'];
    }
    return pm;
  }
}
