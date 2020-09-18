import 'package:sqflite/sqflite.dart' as sqlLite;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sqlLite.Database> dataBase() async {
    final dbPath = await sqlLite.getDatabasesPath();
    return await sqlLite.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lang REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.dataBase();
    db.insert(
      table,
      data,
      conflictAlgorithm: sqlLite.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.dataBase();
    return db.query(table);
  }
}
