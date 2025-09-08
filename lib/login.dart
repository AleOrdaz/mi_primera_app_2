import 'package:flutter/material.dart';
import 'package:app89/constantes.dart' as cons;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool mostrarOcultar = false;
  final usuario = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Obtiene el valor/tamaño de la ventana actual
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView( //Equivalente a un scroll
        padding: EdgeInsets.all(size.height * 0.075), ///size.height * 1 -> 100%
                                                  ///size.height * 0.5 -> 50%
        child: Column(
          ///centrar a los hijos en el centro toda la vista
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05,),
            Text(
              'INICIO DE SESIÓN',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: cons.azulito2
              ),
            ),// hijo
            SizedBox(height: size.height * 0.075,),
            buildRow('Usuario:'),
            buildTextFormField('Escribe tu usuario', false),
            SizedBox(height: size.height * 0.075,),
            buildRow('Contraseña:'),
            buildTextFormField('Escribe tu contraseña', true),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Olvidaste tu contraseña?',
                  style: TextStyle(color: cons.gris),
                )
              ],
            ),
            SizedBox(height: size.height * 0.075,),
            ElevatedButton(
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: cons.azulito,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  fixedSize: Size(size.width * 0.75, 45)
              ),
              child: Text(
                'Ingresar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                  color: cons.blanco
                ),
              ),
            )
          ],
        ), /// hijos
      )
    );
  }

  Row buildRow(String text) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 16),),
      ],
    );
  }

  TextFormField buildTextFormField(String text, bool band) {
    return TextFormField(
      controller: band ? password : usuario,
      obscureText: band ? mostrarOcultar : false, //TRUE -> oculta el texto del input
      decoration: InputDecoration(
        filled: true,
        fillColor: cons.blanco,
        suffixIcon: band ? IconButton(
          onPressed: (){
            setState(() { ///Actualizar el estado de la vista
              mostrarOcultar = !mostrarOcultar;
            });
          },
          icon: mostrarOcultar ? Icon(Icons.visibility_off) :
          Icon(Icons.visibility),
        ) : null,
        prefixIcon: band ? Icon(Icons.password, color: cons.azulito,) :
        Icon(Icons.person, color: cons.azulito,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        hintText: text,
      ),
    );
  }
}
