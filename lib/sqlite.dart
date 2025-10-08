import 'package:app1920/utils/database.dart';
import 'package:flutter/material.dart';

class SQLite extends StatefulWidget {
  const SQLite({super.key});

  @override
  State<SQLite> createState() => _SQLiteState();
}

final dbHelper = DatabaseHelper();

class _SQLiteState extends State<SQLite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //CRUD
          //CREATE-READ-UPDATE-DELETE
          //Agregar-Obtener-Editar-Eliminar
          ElevatedButton(
            onPressed: () {
              _insert(context);
            },
            child: Text('Agregar datos C'),
          ),
          ElevatedButton(
            onPressed: () {
              _select();
            },
            child: Text('Obtener datos R'),
          ),
          ElevatedButton(
            onPressed: () {
              _update();
            },
            child: Text('Editar datos U'),
          ),
          ElevatedButton(
            onPressed: () {
              _delete();
            },
            child: Text('Eliminar datos D'),
          )
        ],
      ),
    );
  }

  // Button onPressed methods
  void _insert(BuildContext context) async {
    final name = TextEditingController();
    final age = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Insertar nuevo usuario'),
            content: Column(
              children: [
                TextFormField(
                  controller: name,
                ),
                TextFormField(
                  controller: age,
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el AlertDialog
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  ///JSON
                  Map<String, dynamic> row = {
                    DatabaseHelper.columnName: name.text,
                    DatabaseHelper.columnAge: int.parse(age.text)
                  };
                  final id = await dbHelper.insert(row);

                  debugPrint('inserted row id: $id'); // = print("");

                  Navigator.of(context).pop(); // Cerrar el AlertDialog
                },
                child: const Text('Guardar'),
              ),
            ],

          );
          )
        }

        void _select() async {
      final allRows = await dbHelper.queryAllRows();
      debugPrint('query all rows:');
      //singleton.users = allRows;
      for (final row in allRows) {
        debugPrint(row.toString());
      }

      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => const Users()));
    }

    void _update(ID, NOMBRE, EDAD) async {
      // row to update
      Map<String, dynamic> row = {
        DatabaseHelper.columnId: 1,
        DatabaseHelper.columnName: 'Mary',
        DatabaseHelper.columnAge: 32
      };
      final rowsAffected = await dbHelper.update(row);
      debugPrint('updated $rowsAffected row(s)');
    }

    void _delete(ID) async {
      // Assuming that the number of rows is the id for the last row.
      final id = await dbHelper.queryRowCount();
      final rowsDeleted = await dbHelper.delete(id);
      debugPrint('deleted $rowsDeleted row(s): row $id');
    }
  }
