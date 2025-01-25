import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'favorites.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE favorite_locations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            city_name TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertFavorite(String cityName) async {
    final db = await database;
    return await db.insert('favorite_locations', {'city_name': cityName});
  }

  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    final db = await database;
    return await db.query('favorite_locations', orderBy: 'id DESC');
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete('favorite_locations', where: 'id = ?', whereArgs: [id]);
  }
}
