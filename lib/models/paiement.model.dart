import 'package:uuid/uuid.dart';

class Paiement {
  String? id;
  int montant = 0;
  int? total;
  DateTime? dateGeneration;
  DateTime? datePaiement;
  String? idutilisateur;
  String? idpayeur;
  String? nompayeur;
  String? nom;
  String? numero;
  int statut = 0;

  Paiement(int montant) {
    this.montant = montant;
    id = generateID();
    dateGeneration = DateTime.now();
  }

  String contactToIdentifiant(String numero) {
    return numero.split(' ').join('').split('-').join('');
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
      'nom': nom,
      'total': total,
      'dateGeneration':
          dateGeneration != null ? dateGeneration!.toIso8601String() : null,
      'datePaiement':
          datePaiement != null ? datePaiement!.toIso8601String() : null,
      'idutilisateur': idutilisateur,
      'idpayeur': idpayeur,
      'nompayeur': nompayeur,
      'statut': statut,
    };
  }

  factory Paiement.fromMap(Map<String, dynamic> map) {
    Paiement u;

    if (map['montant'] != null) {
      u = Paiement(map['montant']);
      if (map['id'] != null) {
        u.id = map['id'];
      }
      if (map['total'] != null) {
        u.id = map['total'];
      }
      if (map['numero'] != null) {
        u.numero = map['numero'];
      }
      if (map['nom'] != null) {
        u.nom = map['nom'];
      }
      if (map['dateGeneration'] != null) {
        u.dateGeneration = DateTime.parse(map['dateGeneration']);
      }
      if (map['datePaiement'] != null) {
        u.datePaiement = DateTime.parse(map['datePaiement']);
      }
      if (map['idutilisateur'] != null) {
        u.idutilisateur = map['idutilisateur'];
      }
      if (map['idpayeur'] != null) {
        u.idutilisateur = map['idpayeur'];
      }
      if (map['nompayeur'] != null) {
        u.nompayeur = map['nompayeur'];
      }
      if (map['statut'] != null) {
        u.statut = map['statut'];
      } else {
        u.statut = 0;
      }
    } else {
      return u = new Paiement(0);
    }
    return u;
  }
}
