import 'package:app89/home.dart';
import 'package:app89/mapa.dart';
import 'package:app89/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app89/constantes.dart' as cons;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences sharedPreferences;
  //late -> que despues se le asigna su valor
  bool mostrarOcultar = false;
  final usuario = TextEditingController();
  final password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///INITSTATE NO PUEDE SER UNA FUNCIÓN ASYNC
    initShared();
  }

  initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();


    //REVISAR SI TIENE LA SESIÓN ABIERTA
    bool band = sharedPreferences.getBool('band') ?? false;
    if(band) {
      //LA SESIÓN ABIERTA O INICIADA
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Mapa()));
    } else {
      // NO SE HACE NADA, SE QUEDA EN LOGIN
    }


    /**BOTON DE CERRAR SESIÓN/
     *
     */
    sharedPreferences.setBool('band', false);
  }

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
            Image.asset(
              'img/imagen1.png', //nombre y su ubicación
              width: 100, height: 100, //tamaño de la img
              fit: BoxFit.cover, //si ocupa o no todo el espacio
            ),
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
                setState(() {
                  /*El usuario y contraseña son correctos*/
                  if(usuario.text  == cons.user &&
                      password.text == cons.pass) {
                    //ALMACENAMOS EN SHARED
                    //CADA VEZ QUE INICIE SESIÓN CORRECTAMENTE
                    sharedPreferences.setString('user', usuario.text);
                    sharedPreferences.setString('pass', password.text);
                    sharedPreferences.setBool('band', true);

                    //Cambiar de vista
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  } else {
                    //mostramos un mensaje de error (Snackbar)
                    ShowSnackbar(context, 'Usuario invalido', 20);
                  }
                });
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
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  signInWithGoogle();
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: cons.azulito,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  fixedSize: Size(size.width * 0.75, 45)
              ),
              child: Text(
                'Ingresar con GMAIL',
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

  Future<User?> signInWithGoogle() async {
    try {
      FirebaseAuth.instance.setLanguageCode('es');

      await _googleSignIn.signOut(); // Asegurar que no haya una sesión previa
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // El usuario canceló el login

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          //menssageLogin = 'La cuenta ya existe con un proveedor diferente.';
          break;
        case 'invalid-credential':
          //menssageLogin = 'Las credenciales no son válidas.';
          break;
        case 'user-disabled':
          //menssageLogin = 'El usuario ha sido deshabilitado.';
          break;
        case 'user-not-found':
          //menssageLogin = 'Usuario no encontrado.';
          break;
        case 'wrong-password':
          //menssageLogin = 'Contraseña incorrecta.';
          break;
        case 'invalid-verification-code':
          //menssageLogin = 'Código de verificación inválido.';
          break;
        case 'invalid-verification-id':
          //menssageLogin = 'ID de verificación inválido.';
          break;
        default:
          print('Error de FirebaseAuth: ${e.message}');
      }
      return null;

    } catch (error) {
      print("Error en el inicio de sesión: $error");

      if(error.toString().contains('network_error')){
        //menssageLogin = "Verifica tu conexión a internet";
      } /*else {
        menssageLogin = error.toString();
      }*/

      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    try {
      await FirebaseAuth.instance.signOut();
      print("Sesión cerrada exitosamente.");
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
    //await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }
}
