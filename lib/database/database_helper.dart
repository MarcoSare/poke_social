import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:poke_social/models/event_model.dart';
import 'package:poke_social/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final nameDB = 'BD_POKESOCIAL';
  static final versionDB = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    print("initDataB");
    String pathDB = join(folder.path, nameDB);
    print("rsdgdfgfdgfdgfdgfdgdfgfd");
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    print("se está creando");
    String query = '''CREATE TABLE tblPost (
      id INTEGER PRIMARY KEY,
      dscPost VARCHAR(200),
      datePost DATE
    );''';
    await db.execute(query);
    query = '''CREATE TABLE tblEvent (
      id INTEGER PRIMARY KEY,
      nameEvent VARCHAR(50),
      descEvent VARCHAR(200),
      dateEvent DATE,
      startTimeEvent VARCHAR(8),
      endTimeEvent VARCHAR(8),
      completed INTEGER
    );''';
    await db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion
        .update(tblName, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> DELETE(String tblName, int id) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventModel>> GETALLEVENTS() async {
    var conexion = await database;
    var result = await conexion.query('tblEvent');
    return result.map((event) => EventModel.fromMap(event)).toList();
  }
}
