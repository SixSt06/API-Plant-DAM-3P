import 'package:proyecto3_conduit/proyecto3_conduit.dart';

@Table(name: 'riego')
class _Riego {
  @primaryKey
  int? id;

  @Column(nullable: false)
  late int plantaId;

  @Column(nullable: false)
  late String fechaDeRiego;

  @Column(nullable: false)
  late String notas;
}

class Riego extends ManagedObject<_Riego> implements _Riego {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plantaId': plantaId,
      'fechaDeRiego': fechaDeRiego,
      'notas': notas
    };
  }
}
