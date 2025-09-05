import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();

  group('Database Tests', () {
    late Database db;

    setUpAll(() async {
      db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
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
    });

    //Test per query

    test('Insert checklist', () async {
      await db.insert('groceryList', {
        'budget': 5000.0,
        'created_at': 'September 4, 2025',
      });

      final List<Map<String, dynamic>> items = await db.query('groceryList');
      expect(items.length, 1);
      expect(items[0]['budget'], 5000.0);
    });

    test('Insert grocery Item', () async {
      List<Map<String, dynamic>> groceryItems = [
        {
          'groceryList_id': 1,
          'itemName': 'Sunsilk',
          'quantity': 12,
          'estimatedPrice': 7.0,
          'actualPrice': 0.0,
          'created_at': 'September 4, 2025',
        },
        {
          'groceryList_id': 1,
          'itemName': 'safeguard',
          'quantity': 2,
          'estimatedPrice': 50.0,
          'actualPrice': 0.0,
          'created_at': 'September 4, 2025',
        },
        {
          'groceryList_id': 1,
          'itemName': 'ASukal 1/4',
          'quantity': 4,
          'estimatedPrice': 15.0,
          'actualPrice': 0.0,
          'created_at': 'September 4, 2025',
        },
      ];

      var batch = db.batch();

      for (var groceryItem in groceryItems) {
        batch.insert('groceryItem', groceryItem);
      }

      await batch.commit(noResult: true);

      final List<Map<String, dynamic>> items = await db.query(
        'groceryItem',
        where: 'groceryList_id = ?',
        whereArgs: [1],
      );

      expect(items.length, 3);
    });
  });
}
