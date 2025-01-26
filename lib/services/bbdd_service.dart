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

  // Inicializar la base de datos
 Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  return openDatabase(
    join(dbPath, 'app_data.db'),
    version: 2,
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
          city_name TEXT NOT NULL
        )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Agregar la columna is_registered en la tabla "user" si no existe
        await db.execute('''
          ALTER TABLE user ADD COLUMN is_registered INTEGER NOT NULL DEFAULT 0
        ''');
      }
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

    if (result.isNotEmpty) {
      return result.first['is_registered'] == 1;
    }
    return false;
  }

  // Insertar usuario en la tabla "user"
  Future<int> insertUser({
    required String username,
    required String name,
    required String surname,
    required String birthDate,
  }) async {
    final db = await database;

    // Elimina cualquier usuario previo, ya que solo habrá uno.
    await db.delete('user');

    return await db.insert('user', {
      'username': username,
      'name': name,
      'surname': surname,
      'birth_date': birthDate,
      'is_registered': 0,  // Marca el usuario como no registrado inicialmente
    });
  }

  // Actualizar el estado de registro (is_registered) a 1
  Future<void> updateRegistrationStatus(bool isRegistered) async {
    final db = await database;
    
    // Actualizar el campo 'is_registered' en la tabla 'user'
    await db.update(
      'user',
      {'is_registered': isRegistered ? 1 : 0},
      where: 'id = ?',
      whereArgs: [1], // Asumimos que hay un solo usuario, así que se actualiza el primer registro.
    );
  }

  // Obtener los datos del usuario
  Future<Map<String, dynamic>?> fetchUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('user', limit: 1);

    return result.isNotEmpty ? result.first : null;
  }

  // Métodos para la tabla "favorite_locations"
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

  // Método para limpiar las tablas
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('user');
    await db.delete('favorite_locations');
  }
}
