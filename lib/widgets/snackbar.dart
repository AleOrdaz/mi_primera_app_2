import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:app89/constantes.dart' as cons;

ShowSnackbar(BuildContext _context, String texto, int duration) {
  ///Gestionar el momento en el que debe mostrar el mostrar el widget
  ///dependiendo del contexto actual (protección de errores de creacción)
  SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: cons.negro,
        content: Text(
          texto, textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        action: SnackBarAction(
          label: ' X ',
          onPressed: () {},
          textColor: Colors.white,
          disabledTextColor: Colors.grey,
        ),
      ),
    );
  });
}