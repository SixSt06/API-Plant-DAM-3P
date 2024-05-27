import 'package:proyecto3_conduit/proyecto3_conduit.dart';

class Proyecto3Configuration extends Configuration {
  Proyecto3Configuration(String path) : super.fromFile(File(path));

  late DatabaseConfiguration database;
}
