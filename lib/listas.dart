import 'package:flutter/material.dart';
import 'package:app89/constantes.dart' as cons;

class Listas extends StatefulWidget {
  const Listas({super.key});

  @override
  State<Listas> createState() => _ListasState();
}

class _ListasState extends State<Listas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: cons.usuarios.length, //Tamaño de la lista, 
        // cuanto elementos se van a iterar
        padding: EdgeInsets.all(50),
        itemBuilder: (BuildContext context, int index) {
          var usuario = cons.usuarios[index].toString().split('#');
          //var = Toman cualquier valor
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(usuario[0]),
                    Text('${usuario[1]} ${usuario[2]}'),
                  ],
                ),
                Text(usuario[3]),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Text(usuario[4]),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {

                        });
                      },
                      child: Icon(Icons.edit, color: Colors.blue,),
                    ),
                    usuario[5] == '1' ? InkWell(
                      onTap: () {
                        setState(() {

                        });
                      },
                      child: Icon(Icons.delete, color: Colors.red,),
                    ) : Container()
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
