import 'package:proyecto3_conduit/models/planta.dart';
import 'package:proyecto3_conduit/proyecto3_conduit.dart';

class PlantaController extends ResourceController {
  PlantaController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAll() async {
    final plantQuery = Query<Planta>(context);
    final plants = await plantQuery.fetch();

    return Response.ok(plants);
  }

  @Operation.get('id')
  Future<Response> getByID(@Bind.path('id') int id) async {
    final plantaQuery = Query<Planta>(context)..where((u) => u.id).equalTo(id);

    final planta = await plantaQuery.fetchOne();

    if (planta == null) {
      return Response.notFound();
    }
    return Response.ok(planta);
  }

  @Operation.post()
  Future<Response> createPlanta() async {
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final query = Query<Planta>(context)
      ..values.nombre = body['nombre'] as String
      ..values.frecuenciaDeRiego = body['frecuenciaDeRiego'] as String
      ..values.foto = body['foto'] as String;

    try {
      final insertedPlanta = await query.insert();
      return Response.ok(insertedPlanta);
    } catch (e) {
      return Response.serverError(body: {'error': e.toString()});
    }
  }

  @Operation.put('id')
  Future<Response> updatePlanta(@Bind.path('id') int id) async {
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final query = Query<Planta>(context)
      ..where((planta) => planta.id).equalTo(id)
      ..values.nombre = body['nombre'] as String
      ..values.frecuenciaDeRiego = body['frecuenciaDeRiego'] as String
      ..values.foto = body['foto'] as String;

    final updatedPlanta = await query.updateOne();

    if (updatedPlanta == null) {
      return Response.notFound(body: {'error': 'Planta not found'});
    }

    return Response.ok(updatedPlanta);
  }

  @Operation.delete('id')
  Future<Response> deletePlanta(@Bind.path('id') int id) async {
    final query = Query<Planta>(context)
      ..where((planta) => planta.id).equalTo(id);

    final deletedCount = await query.delete();

    if (deletedCount == 0) {
      return Response.notFound(body: {'error': 'Planta not found'});
    }

    return Response.ok({'message': 'Planta deleted'});
  }
}
