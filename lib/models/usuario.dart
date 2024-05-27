import 'package:proyecto3_conduit/proyecto3_conduit.dart';

@Table(name: 'usuario')
class _Usuario {
  @primaryKey
  int? id;

  @Column(nullable: false)
  late String nombre;

  @Column(nullable: false)
  late String password;
}

class Usuario extends ManagedObject<_Usuario> implements _Usuario {
  bool validarCredenciales(String nombreInput, String passwordInput) {
    return nombre == nombreInput && password == passwordInput;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre, 'password': password};
  }
}
