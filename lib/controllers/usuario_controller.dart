import 'package:proyecto3_conduit/models/usuario.dart';
import 'package:proyecto3_conduit/proyecto3_conduit.dart';

class UsuarioController extends ResourceController {
  UsuarioController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAll() async {
    final usuarioQuery = Query<Usuario>(context);
    final usuarios = await usuarioQuery.fetch();

    return Response.ok(usuarios);
  }

  @Operation.get('id')
  Future<Response> getByID(@Bind.path('id') int id) async {
    final usuarioQuery = Query<Usuario>(context)
      ..where((u) => u.id).equalTo(id);

    final usuario = await usuarioQuery.fetchOne();

    if (usuario == null) {
      return Response.notFound();
    }
    return Response.ok(usuario);
  }

  @Operation.post()
  Future<Response> createUsuario() async {
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final query = Query<Usuario>(context)
      ..values.nombre = body['nombre'] as String
      ..values.password = body['password'] as String;

    try {
      final insertedUsuario = await query.insert();
      return Response.ok(insertedUsuario);
    } catch (e) {
      return Response.serverError(body: {'error': e.toString()});
    }
  }

  @Operation.put('id')
  Future<Response> updateUsuario(@Bind.path('id') int id) async {
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final query = Query<Usuario>(context)
      ..where((usuario) => usuario.id).equalTo(id)
      ..values.nombre = body['nombre'] as String
      ..values.password = body['password'] as String;

    final updatedUsuario = await query.updateOne();

    if (updatedUsuario == null) {
      return Response.notFound(body: {'error': 'Usuario not found'});
    }

    return Response.ok(updatedUsuario);
  }

  @Operation.delete('id')
  Future<Response> deleteUsuario(@Bind.path('id') int id) async {
    final query = Query<Usuario>(context)
      ..where((usuario) => usuario.id).equalTo(id);

    final deletedCount = await query.delete();

    if (deletedCount == 0) {
      return Response.notFound(body: {'error': 'Usuario not found'});
    }

    return Response.ok({'message': 'Usuario deleted'});
  }
}
