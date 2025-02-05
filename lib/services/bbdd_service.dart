import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  static final DBService _instance = DBService._();
  static Database? _database;

  DBService._();

  factory DBService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'app_data.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            name TEXT NOT NULL,
            surname TEXT NOT NULL,
            birth_date TEXT NOT NULL,
            is_registered INTEGER NOT NULL DEFAULT 0
          )
        ''');

        db.execute('''
          CREATE TABLE favorite_locations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            city_name TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL
          )
        ''');
      },
    );
  }

  // Verificar si el usuario ya está registrado
  Future<bool> isUserRegistered() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      columns: ['is_registered'],
      limit: 1,
    );
    return result.isNotEmpty && result.first['is_registered'] == 1;
  }

  // Insertar usuario en la tabla "user"
  Future<int> insertUser({
    required String username,
    required String name,
    required String surname,
    required String birthDate,
  }) async {
    final db = await database;
    await db.delete(
        'user'); // Elimina cualquier usuario previo, ya que solo habrá uno.
    return await db.insert('user', {
      'username': username,
      'name': name,
      'surname': surname,
      'birth_date': birthDate,
      'is_registered': 0, // Marca el usuario como no registrado inicialmente
    });
  }

  // Actualizar el estado de registro (is_registered) a 1
  Future<void> updateRegistrationStatus(bool isRegistered) async {
    final db = await database;
    await db.update(
      'user',
      {'is_registered': isRegistered ? 1 : 0},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  // Obtener los datos del usuario
  Future<Map<String, dynamic>?> fetchUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('user', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  // Métodos para la tabla "favorite_locations"
  // Método modificado para evitar duplicados
  Future<int> insertFavorite(String cityName, double lat, double lon) async {
    final db = await database;

    // Guardar valores redondeados a 2 decimales
    return await db.insert('favorite_locations', {
      'city_name': cityName,
      'latitude': double.parse(lat.toStringAsFixed(2)),
      'longitude': double.parse(lon.toStringAsFixed(2)),
    });
  }

  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    final db = await database;
    return await db.query('favorite_locations', orderBy: 'id DESC');
  }

  Future<void> deleteFavorite(String cityName, double lat, double lon) async {
    final db = await database;

    // Redondeamos antes de eliminar
    double roundedLat = double.parse(lat.toStringAsFixed(2));
    double roundedLon = double.parse(lon.toStringAsFixed(2));

    await db.delete(
      'favorite_locations',
      where:
          'city_name = ? AND ROUND(latitude, 2) = ? AND ROUND(longitude, 2) = ?',
      whereArgs: [cityName, roundedLat, roundedLon],
    );
  }

  // Método para limpiar las tablas
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('user');
    await db.delete('favorite_locations');
  }

  Future<bool> isCityFavorite(String cityName, double lat, double lon) async {
    final db = await database;

    // Redondear lat y lon a 2 decimales
    double roundedLat = double.parse(lat.toStringAsFixed(2));
    double roundedLon = double.parse(lon.toStringAsFixed(2));

    final List<Map<String, dynamic>> result = await db.query(
      'favorite_locations',
      where:
          'city_name = ? AND ROUND(latitude, 2) = ? AND ROUND(longitude, 2) = ?',
      whereArgs: [cityName, roundedLat, roundedLon],
    );

    return result.isNotEmpty;
  }
}
