import 'package:goalinter/data/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'goalinter_project.db';
  final int version = 1;
  final String tableDatabase = 'myBook';
  final String columnId = 'id';
  final String columnIdBooking = 'id_booking';
  final String columnFirstname = 'firstname';
  final String columnLastname = 'lastname';
  final String columnDatetimeStart = 'datetime_start';
  final String columnDatetimeEnd = 'datetime_end';
  final String columnTypeField = 'typeField';
  final String columnSlip = 'slip';


  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableDatabase ($columnId INTEGER PRIMARY KEY, $columnIdBooking TEXT, $columnFirstname TEXT, $columnLastname TEXT, $columnDatetimeStart TEXT, $columnDatetimeEnd TEXT, $columnTypeField TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<List<SQLiteModel>> readSQLite() async {
    Database database = await connectedDatabase();
    List<SQLiteModel> results = [];
    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    // print('### maps on SQLitHelper ==>> $maps');
    for (var item in maps) {
      SQLiteModel model = SQLiteModel.fromMap(item);
      results.add(model);
    }
    return results;
  }

  Future<Null> insertValueToSQLite(SQLiteModel sqLiteModel) async {
    Database database = await connectedDatabase();
    await database.insert(tableDatabase, sqLiteModel.toMap()).then(
        (value) => print('### insert Value name ==>> ${sqLiteModel.firstname}'));
  }

  Future<void> deleteSQLiteWhereId(int id) async {
    Database database = await connectedDatabase();
    await database
        .delete(tableDatabase, where: '$columnId = $id')
        .then((value) => print('### Success Delete id ==> $id'));
  }

  Future<void> emptySQLite() async {
    Database database = await connectedDatabase();
    await database
        .delete(tableDatabase)
        .then((value) => print('### Empty SQLite Success'));
  }
}