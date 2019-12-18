import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/pack.dart';


class DatabaseManager {
  static DatabaseManager _databaseManager;
  static Database _database;

  DatabaseManager._createInstance();

  factory DatabaseManager() {
    if (_databaseManager == null) {
      _databaseManager = DatabaseManager._createInstance();
    }
    return _databaseManager;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'database.db';
    var db = await openDatabase(path, version: 1, onCreate: createDB);
    return db;
  }

  Future<void> createDB(Database db, int version) async {
    await db.execute("CREATE TABLE Shipments (sender STRING, date STRING, status STRING)");
  }

  Future<List<Map<String, dynamic>>> getShipmentsList() async {
    Database db = await this.database;
    return await db.query("Shipments");
  }

  Future<int> insertShipment(Pack p) async {
    Database db = await this.database;
    return await db.insert("Shipments", p.toMap());
  }

  Future<int> updateShipment(Pack p) async {
    Database db = await this.database;
    return await db.update("Shipments", values)
  }

}

//https://simpleactivity435203168.wordpress.com/2019/09/19/to-do-list-in-flutter-with-sqlite-as-local-database/