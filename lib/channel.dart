import 'package:conduit_postgresql/conduit_postgresql.dart';
import 'package:proyecto3_conduit/config/proyecto3_configuration.dart';
import 'package:proyecto3_conduit/controllers/planta_controller.dart';
import 'package:proyecto3_conduit/controllers/riego_controller.dart';
import 'package:proyecto3_conduit/controllers/usuario_controller.dart';
import 'package:proyecto3_conduit/proyecto3_conduit.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://conduit.io/docs/http/channel/.
class Proyecto3ConduitChannel extends ApplicationChannel {
  late ManagedContext context;

  @override
  Future prepare() async {
    final config = Proyecto3Configuration(options!.configurationFilePath!);
    final dbConfig = config.database;
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        dbConfig.username,
        dbConfig.password,
        dbConfig.host,
        dbConfig.port,
        dbConfig.databaseName);

    context = ManagedContext(dataModel, persistentStore);

    CORSPolicy.defaultPolicy.allowedOrigins = ["*"];
    CORSPolicy.defaultPolicy.allowedMethods = ["GET", "POST", "PUT", "DELETE"];

    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://conduit.io/docs/http/request_controller/
    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    router.route("/usuario/[:id]").link(() => UsuarioController(context));
    router.route("/planta/[:id]").link(() => PlantaController(context));
    router.route("/riego/[:id]").link(() => RiegoController(context));

    return router;
  }
}
