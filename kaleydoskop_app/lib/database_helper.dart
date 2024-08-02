import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dream_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        try {
          await db.execute(
            "CREATE TABLE dreams(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, details TEXT, date_time TEXT)",
          );
        } catch (e) {
          print('Tablolar oluşturulurken hata oluştu: ${e.toString()}');
        }
      },
    );
  }

  Future<void> insertDream(String title, String details, String dateTime) async {
    final db = await instance.database;
    try {
      await db.insert(
        'dreams',
        {'title': title, 'details': details, 'date_time': dateTime},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Rüya eklenirken hata oluştu: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getDreams() async {
    final db = await instance.database;
    try {
      return await db.query('dreams', orderBy: 'date_time DESC');
    } catch (e) {
      print('Rüyalar alınırken hata oluştu: ${e.toString()}');
      return [];
    }
  }

  Future<void> updateDream(int id, String title, String details) async {
    final db = await instance.database;
    try {
      await db.update(
        'dreams',
        {'title': title, 'details': details},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Rüya güncellenirken hata oluştu: ${e.toString()}');
    }
  }

  Future<void> deleteDream(int id) async {
    final db = await instance.database;
    try {
      await db.delete(
        'dreams',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Rüya silinirken hata oluştu: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> getDream(int id) async {
    final db = await instance.database;
    try {
      final results = await db.query(
        'dreams',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (results.isNotEmpty) {
        return results.first;
      }
      return null;
    } catch (e) {
      print('Rüya alınırken hata oluştu: ${e.toString()}');
      return null;
    }
  }
}