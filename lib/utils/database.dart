import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

///CLASE PARA LA CREACIÓN DE LA BD Y FUNCIONES DEL CRUD
class DatabaseHelper {
  static const _databaseName = "MyDatabase.db"; //NOMBRE DE SU BD
  static const _databaseVersion = 1; //VERSION DE LA BD

  static const table = 'my_table'; //NOMBRE DE LA TABLA
  //SUS ATRIBUTOS
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnAge = 'age';

  late Database _db; //SE CREA LA INSTANCIA DE LA BD A TRAVÉS DE SQLITE


  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final path;

    ///Obtención de la dirección/path para almacenar la BD
    if (kIsWeb) { //Indicamos si se va abrir en web
      //Dirección en donde se guardara la BD
      path = "/assets/db"; //Local dentro de nuestra app (visible)
    } else {
      //Se almacena de forma oculta dentro de la app
      final documentsDirectory = (await getApplicationDocumentsDirectory())
          .path;
      path = join(documentsDirectory, _databaseName);
    }

    ///fin de obtención
    ///CRAER Y ABRIR LA BD
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY autoincrement,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL
      )
    ''');
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }
}