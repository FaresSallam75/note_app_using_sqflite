import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDatabase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  intialDatabase() async {
    // to specify path for database
    String databasePath = await getDatabasesPath();
    // get  database name and it to database path
    String databaseName = join(databasePath, "fares.db");
    Database myDb = await openDatabase(databaseName,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return myDb;
  }

  // 1 - called only one time when database version is changed
  // 2 - use it if you didn't want delete database  its keep data
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // use this if you want to add column in table
    //db.execute("alter table notes add column color TEXT ");
  
    print("onUpgrade =====================================");
  }

  // called only one time when database created for first time
  _onCreate(Database db, int version) async {
    // if you want to add more than one table prefer using batch
    // batch ====> doing several actions using one struction at the same time
    Batch batch = db.batch();
    batch.execute(''' 
        CREATE TABLE `notes` (
       "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
       "title" TEXT NOT NULL,
       "notes" TEXT NOT NULL,
       "color" TEXT NOT NULL
      )
      ''');

    batch.execute(''' 
      CREATE TABLE `users` (
       "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
       "username" TEXT NOT NULL,
       "email"    TEXT NOT NULL,
       "password" TEXT NOT NULL
      ) 
      ''');


    // perform that
    await batch.commit();
    print("onCreate =====================================");
  }

  Future<List<Map>> readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  deleteAllDataBase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = join(databasePath, "fares.db");
    await deleteDatabase(databaseName);
  }

  //"title" TEXT NOT NULL,
  //"note" TEXT NOT NULL,
  //"color" TEXT NOT NULL,
  //"Aid" INTEGER, CONSTRAINT fk_note_admin FOREIGN KEY (Aid) REFERENCES Admins(id)

  // ===============================================================
  // ===============================================================
  // Observation for method

  Future<List<Map>> read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  Future<int> update(
      String table, Map<String, Object?> values, String where) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: where);
    return response;
  }

  Future<int> delete(String tabel, String where) async {
    Database? myDb = await db;
    int response = await myDb!.delete(
      tabel,
      where: where,
    );
    return response;
  }
}
