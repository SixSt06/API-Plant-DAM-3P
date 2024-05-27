import 'package:proyecto3_conduit/proyecto3_conduit.dart';

Future main() async {
  final app = Application<Proyecto3ConduitChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
