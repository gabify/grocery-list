import 'package:grocery_list/Services/Checklist.dart';
import 'package:grocery_list/Services/Item.dart';
import 'package:grocery_list/Services/Product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  Databasehelper._internal();

  static final Databasehelper _instance = Databasehelper._internal();

  factory Databasehelper() => _instance;

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB('groceryDB_1.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE checklist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        budget REAL,
        total_items INTEGER,
        bought_items INTEGER,
        isDone INTEGER,
        created_at TEXT
      )
  ''');

    await db.execute('''
      CREATE TABLE Item (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        checkList_id INTEGER,
        product_id INTEGER,
        quantity INTEGER,
        isBought INTEGER
      )
  ''');

    await db.execute('''
      CREATE TABLE Product (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_name TEXT,
        price REAL,
        category TEXT
      )
  ''');
  }

  /* Create functions */

  //Create product
  Future<int> insertProduct(Product newProduct) async {
    final db = await database;

    return await db.insert('Product', newProduct.toMap());
  }

  //Create Checklist
  Future<int> _insertChecklist(Transaction tnx, Checklist newChecklist) async {
    return await tnx.insert('checklist', newChecklist.toMap());
  }

  //Create Item
  Future<void> _insertItems(
    Transaction tnx,
    List<Item> items,
    int checklistId,
  ) async {
    var batch = tnx.batch();

    final joinedItems = items.map((i) {
      i.checklistId = checklistId;
      return i.toMap();
    });

    for (var item in joinedItems) {
      await tnx.insert('Item', item);
    }

    await batch.commit(noResult: true);
  }

  //Transaction for creating item and creating checklist
  Future<int?> insertGroceryList(
    Checklist newChecklist,
    List<Item> items,
  ) async {
    final db = await database;

    return await db.transaction((tnx) async {
      try {
        int checklistId = await _insertChecklist(tnx, newChecklist);
        await _insertItems(tnx, items, checklistId);

        return checklistId;
      } catch (e) {
        return null;
      }
    });
  }
  /* Retrieve functions */

  //Get Products
  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;

    return await db.query('Product');
  }

  //Get Checklists
  Future<List<Map<String, dynamic>>> getChecklists() async {
    final db = await database;

    return await db.query('checklist', orderBy: 'id DESC');
  }

  Future<List<Map<String, dynamic>>> getItems(int checklistId) async {
    final db = await database;

    return await db.query(
      'Item',
      where: 'checkList_id = ?',
      whereArgs: [checklistId],
    );
  }
}




 /*  //Save to DB

  Future<int?> saveCheckList(
    Map<String, dynamic> groceryList,
    List<Groceryitem> groceryItems,
  ) async {
    final db = await database;

    return await db.transaction((tnx) async {
      try {
        int groceryList_id = await insertGroceryList(tnx, groceryList);

        final convertedToMap = groceryItems.map((item) {
          item.setGroceryListId = groceryList_id;

          return item.toMap();
        }).toList();

        await insertGroceryItems(tnx, convertedToMap);

        return groceryList_id;
      } catch (e) {
        return null;
      }
    });
  }

  Future<int> insertChecklist(
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

  //Update to DB

  Future<void> updateIfBought(List<Map<String, dynamic>> groceryItems) async {
    final db = await database;
    var batch = db.batch();

    for (var groceryItem in groceryItems) {
      batch.update(
        'groceryItem',
        groceryItem,
        where: 'id = ?',
        whereArgs: groceryItem['id'],
      );
    }

    await batch.commit(noResult: false);
  }

  //Retrieve from DB

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
 */