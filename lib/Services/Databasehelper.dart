import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  Databasehelper._internal();

  static final Databasehelper _instance = Databasehelper._internal();

  factory Databasehelper() => _instance;

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB('grocery_list_db.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE groceryList (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        budget REAL,
        created_at TEXT
      )
  ''');

    await db.execute('''
      CREATE TABLE groceryItem (
        id INTEGERE PRIMARY KEY AUTOINCREMENT,
        groceryList_id INTEGER,
        itemName TEXT,
        estimatedPrice REAL,
        actualPrice REAL,
        created_at TEXT
      )
  ''');
  }

  Future<int> insertGroceryList(Map<String, dynamic> groceryList) async {
    final db = await database;
    return await db.insert('groceryList', groceryList);
  }

  Future<void> insertGroceryItems(
    List<Map<String, dynamic>> groceryItems,
  ) async {
    final db = await database;
    var batch = db.batch();

    for (var groceryItem in groceryItems) {
      batch.insert('groceryItem', groceryItem);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getGroceryLists() async {
    final db = await database;

    return await db.rawQuery('''SELECT * FROM groceryList ORDER BY id DESC''');
  }

  Future<List<Map<String, dynamic>>> getGroceryItems(int id) async {
    final db = await database;

    return await db.query(
      'groceryItem',
      where: 'groceryList_id = ?',
      whereArgs: [id],
      orderBy: 'id DESC',
    );
  }
}
