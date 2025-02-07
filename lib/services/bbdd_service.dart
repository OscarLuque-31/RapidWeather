import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Servicio de base de datos que maneja la persistencia de datos con SQLite.
class DBService {
  // Instancia única de la base de datos (Singleton)
  static final DBService _instance = DBService._();
  static Database? _database;

  // Constructor privado para evitar múltiples instancias
  DBService._();

  // Método de fábrica para obtener la instancia única
  factory DBService() => _instance;

  /// Obtiene la instancia de la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializa la base de datos y crea las tablas necesarias si no existen.
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'app_data.db'),
      version: 1,
      onCreate: (db, version) {
        // Crear tabla de usuario
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

        // Crear tabla de ubicaciones favoritas
        db.execute(''' 
          CREATE TABLE favorite_locations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            city_name TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL
          )
        ''');

        // Crear tabla de búsquedas recientes
        db.execute(''' 
          CREATE TABLE recent_searches (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            city_name TEXT NOT NULL UNIQUE, 
            search_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          )
        ''');
      },
    );
  }

  // ========================
  // MÉTODOS PARA LA TABLA "USER"
  // ========================

  /// Inserta un usuario en la base de datos.
  /// Si ya existe un usuario, lo reemplaza.
  Future<int> insertUser({
    required String username,
    required String name,
    required String surname,
    required String birthDate,
  }) async {
    final db = await database;
    await db.delete('user'); // Elimina cualquier usuario previo
    return await db.insert('user', {
      'username': username,
      'name': name,
      'surname': surname,
      'birth_date': birthDate,
      'is_registered': 0, // Marca el usuario como no registrado inicialmente
    });
  }

  /// Actualiza el estado de registro del usuario (0: no registrado, 1: registrado).
  Future<void> updateRegistrationStatus(bool isRegistered) async {
    final db = await database;
    await db.update(
      'user',
      {'is_registered': isRegistered ? 1 : 0},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  /// Obtiene los datos del usuario si existe en la base de datos.
  Future<Map<String, dynamic>?> fetchUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('user', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  /// Verifica si el usuario está registrado en la aplicación.
  Future<bool> isUserRegistered() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      columns: ['is_registered'],
      limit: 1,
    );
    return result.isNotEmpty && result.first['is_registered'] == 1;
  }

  // ========================
  // MÉTODOS PARA LA TABLA "FAVORITE_LOCATIONS"
  // ========================

  /// Inserta una nueva ubicación favorita en la base de datos.
  Future<int> insertFavorite(String cityName, double lat, double lon) async {
    final db = await database;
    return await db.insert('favorite_locations', {
      'city_name': cityName,
      'latitude': double.parse(lat.toStringAsFixed(2)), // Redondeo a 2 decimales
      'longitude': double.parse(lon.toStringAsFixed(2)),
    });
  }

  /// Obtiene la lista de ubicaciones favoritas ordenadas por el ID en orden descendente.
  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    final db = await database;
    return await db.query('favorite_locations', orderBy: 'id DESC');
  }

  /// Elimina una ubicación favorita de la base de datos.
  Future<void> deleteFavorite(String cityName, double lat, double lon) async {
    final db = await database;
    double roundedLat = double.parse(lat.toStringAsFixed(2));
    double roundedLon = double.parse(lon.toStringAsFixed(2));

    await db.delete(
      'favorite_locations',
      where:
          'city_name = ? AND ROUND(latitude, 2) = ? AND ROUND(longitude, 2) = ?',
      whereArgs: [cityName, roundedLat, roundedLon],
    );
  }

  /// Verifica si una ciudad está marcada como favorita.
  Future<bool> isCityFavorite(String cityName, double lat, double lon) async {
    final db = await database;
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

  // ========================
  // MÉTODOS PARA LA TABLA "RECENT_SEARCHES"
  // ========================

  /// Inserta una búsqueda reciente en la base de datos.
  /// Si la ciudad ya existe en la lista de búsquedas recientes, la reemplaza.
  Future<void> insertRecentSearch(String cityName) async {
    final db = await database;
    await db.insert(
      'recent_searches',
      {'city_name': cityName},
      conflictAlgorithm: ConflictAlgorithm.replace, // Reemplaza si ya existe
    );
  }

  /// Obtiene las últimas búsquedas recientes (por defecto, las 5 más recientes).
  Future<List<String>> fetchRecentSearches({int limit = 5}) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'recent_searches',
      orderBy: 'search_date DESC',
      limit: limit,
    );

    return result.map((row) => row['city_name'] as String).toList();
  }

  /// Borra todas las búsquedas recientes de la base de datos.
  Future<void> clearRecentSearches() async {
    final db = await database;
    await db.delete('recent_searches');
  }
}
