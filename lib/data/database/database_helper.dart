import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoo/data/model/task_model.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'task';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'task_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               title TEXT,
               description TEXT,
               icon INTEGER,
               date TEXT,
               isDone INTEGER
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertTask(Task task) async {
    final Database db = await database;
    await db.insert(_tableName, task.toMap());
    print('Data saved');
  }

  Future<List<Task>> getTask() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Task.fromMap(res)).toList();
  }

  Future<Task> getTaskById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((res) => Task.fromMap(res)).first;
  }

  Future<void> updateTask(Task task) async {
    final db = await database;

    await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
