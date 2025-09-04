import 'package:grocery_list/Groceryitem.dart';
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
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        groceryList_id INTEGER,
        itemName TEXT,
        quantity INTEGER,
        estimatedPrice REAL,
        actualPrice REAL,
        created_at TEXT
      )
  ''');
  }

  Future<int?> saveCheckList(
    Map<String, dynamic> groceryList,
    List<Groceryitem> groceryItems,
  ) async {
    final db = await database;

    await db.transaction((tnx) async {
      int groceryList_id = await insertGroceryList(tnx, groceryList);

      final convertedToMap = groceryItems.map((item) {
        item.setGroceryListId = groceryList_id;

        return item.toMap();
      }).toList();

      await insertGroceryItems(tnx, convertedToMap);

      return groceryList_id;
    });

    return null;
  }

  Future<int> insertGroceryList(
    Transaction tnx,
    Map<String, dynamic> groceryList,
  ) async {
    return await tnx.insert('groceryList', groceryList);
  }

  Future<void> insertGroceryItems(
    Transaction tnx,
    List<Map<String, dynamic>> groceryItems,
  ) async {
    var batch = tnx.batch();

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
