import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const dbName = "build.db";
  static const dbVersion = 11;

  static const tbName = "build";
  static const colBuildId = "buildId";
  static const colUserEmail = "userEmail";
  static const colMotherboard = "motherboard";
  static const colCPU = "cpu";
  static const colRAM = "ram";
  static const colStorage = "storage";
  static const colPSU = "psu";
  static const colFan = "fan";
  static const colGPU = "gpu";
  static const colDateTime = "dateTime";

  static Future<Database> openDb() async {
    var path = join(await getDatabasesPath(), dbName);
    var sql = "CREATE TABLE IF NOT EXISTS $tbName ($colBuildId INTEGER PRIMARY KEY, $colUserEmail TEXT, $colMotherboard TEXT, $colCPU TEXT, $colRAM TEXT, $colStorage TEXT, $colPSU TEXT, $colFan TEXT, $colGPU TEXT, $colDateTime TEXT)";
    var db = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute(sql);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion <= newVersion) return;
        db.execute("DROP TABLE IF EXISTS $tbName");
        db.execute(sql);
        print("table dropped and recreated");
      },
    );

    return db;
  }

  static Future<void> insertBuild(Map<String, dynamic> build) async {
    try {
      var db = await openDb();

      await db.insert(tbName, build);
    } catch (e) {
      print("Error inserting record: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> fetchBuilds() async {
    try {
      var db = await openDb();

      return db.query(tbName);
    } catch (e) {
      print("Error fetching builds: $e");
      return [];
    }
  }
}