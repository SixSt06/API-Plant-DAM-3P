import 'package:proyecto3_conduit/proyecto3_conduit.dart';

@Table(name: 'planta')
class _Planta {
  @primaryKey
  int? id;

  @Column(nullable: false)
  late String nombre;

  @Column(nullable: false)
  late String frecuenciaDeRiego;

  @Column(nullable: false)
  late String foto;
}

class Planta extends ManagedObject<_Planta> implements _Planta {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'frecuenciaDeRiego': frecuenciaDeRiego,
      'foto': foto
    };
  }
}
