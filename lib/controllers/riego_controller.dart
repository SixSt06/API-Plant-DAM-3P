import 'package:proyecto3_conduit/models/riego.dart';
import 'package:proyecto3_conduit/proyecto3_conduit.dart';

class RiegoController extends ResourceController {
  RiegoController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAll() async {
    final riegoQuery = Query<Riego>(context);
    final riegos = await riegoQuery.fetch();

    return Response.ok(riegos);
  }

  @Operation.get('id')
  Future<Response> getByID(@Bind.path('id') int id) async {
    final riegoQuery = Query<Riego>(context)..where((u) => u.id).equalTo(id);

    final riego = await riegoQuery.fetchOne();

    if (riego == null) {
      return Response.notFound();
    }
    return Response.ok(riego);
  }

  @Operation.post()
  Future<Response> createRiego() async {
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final query = Query<Riego>(context)
      ..values.plantaId = body['plantaId'] as int
      ..values.fechaDeRiego = body['fechaDeRiego'] as String
      ..values.notas = body['notas'] as String;

    try {
      final insertedRiego = await query.insert();
      return Response.ok(insertedRiego);
    } catch (e) {
      return Response.serverError(body: {'error': e.toString()});
    }
  }

  @Operation.put('id')
  Future<Response> updateRiego(@Bind.path('id') int id) async {
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final query = Query<Riego>(context)
      ..where((riego) => riego.id).equalTo(id)
      ..values.plantaId = body['plantaId'] as int
      ..values.fechaDeRiego = body['fechaDeRiego'] as String
      ..values.notas = body['notas'] as String;

    final updatedRiego = await query.updateOne();

    if (updatedRiego == null) {
      return Response.notFound(body: {'error': 'Riego not found'});
    }

    return Response.ok(updatedRiego);
  }

  @Operation.delete('id')
  Future<Response> deleteRiego(@Bind.path('id') int id) async {
    final query = Query<Riego>(context)..where((riego) => riego.id).equalTo(id);

    final deletedCount = await query.delete();

    if (deletedCount == 0) {
      return Response.notFound(body: {'error': 'Riego not found'});
    }

    return Response.ok({'message': 'Riego deleted'});
  }
}
