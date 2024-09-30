import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:animais/app/database/sqlite/script.dart';


class Connection {
  static late Database _db;

  static Future<Database> iniciar() async {
    var path = join(await getDatabasesPath(), 'database.db');
    deleteDatabase(path);

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        createTables.forEach(db.execute);
        insertions.forEach(db.execute);
      },
      singleInstance: true
    );

    return _db;
  }
}