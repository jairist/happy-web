import 'dart:math';

import 'package:flutter/material.dart';

bool isNumeric(String s){
  if(s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null ) ? false : true;

}

int randomNumber(){
  var rng = new Random();
  return rng.nextInt(100000);
}

void mostrarAlerta(BuildContext context, String mensaje){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Informacion'),
        backgroundColor: Colors.greenAccent,
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: ()=> Navigator.of(context).pop()),
        ],
      );
    }
  );
}
void mostrarAlertaParaEditarProveedor(BuildContext context, String mensaje){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Información', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        backgroundColor: Colors.greenAccent,
        content: Text(mensaje, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: ()=> Navigator.of(context).pushNamed('home')),
        ],
      );
    }
  );
}
void mostrarAlertaProveedorSinEvaluaciones(BuildContext context, String mensaje){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Información', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        backgroundColor: Colors.greenAccent,
        elevation: 5,
        
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Volver', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
            onPressed: ()=> Navigator.of(context).pushNamed('home')),
        ],
      );
    }
  );
}
void mostrarAlertaDeError(BuildContext context, String mensaje){
  String mensajeFormateado = '';
  
  if (mensaje == 'EMAIL_EXISTS'){
    mensajeFormateado = 'Este correo eléctronico ya ha sido registrado.';

  }

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Validación'),
        backgroundColor: Colors.redAccent,
        content: Text(mensajeFormateado),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: ()=> Navigator.of(context).pop()),
        ],
      );
    }
  );
}
void mostrarAlertaSinPopResetear(BuildContext context){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Informacion'),
        backgroundColor: Colors.greenAccent,
        content: Text('El campo email no puede estar vacio, por favor introduzca su email para enviar el correo de verificación '),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: ()=> Navigator.of(context).pushNamed('resetear')),
        ],
      );
    }
  );
}

  void mostrarAlertaParaRegistro(BuildContext context){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Ususario no registrado'),
        backgroundColor: Colors.greenAccent,
        content: Text('Usuario no registrador por favor registrate para acceder, es super fácil'),
        actions: <Widget>[
          FlatButton(
            child: Text('REGISTRARME'),
            onPressed: ()=> Navigator.pushNamed(context, 'registro')),
        ],
      );
    }
  );
}
 void mostrarAlertaParaResetearClave(BuildContext context, String email){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Resetear Clave'),
        backgroundColor: Colors.greenAccent,
        content: Text('Un correo electronico de recuperación ha sido enviado a el email: $email'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ir al Login'),
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'login')),
        ],
      );
    }
  );
}


List<MaterialColor> colors = [
  Colors.pink,
  Colors.amber,
  Colors.teal,
  Colors.lightBlue,
];
List<String> newTexts = [
  "Proveedores!",
  "Servicios!",
  "Evaluaciones!",
  "Detalles!"
];
List<IconData> icons = [
  Icons.room_service,
  Icons.track_changes,
  Icons.sentiment_very_satisfied,
  Icons.question_answer,
  Icons.add
];
List<String> elementsName = [
  "Hydrogen",
  "Helium",
  "Lithium",
  "Beryllium",
  "Boron",
  "Carbon",
  "Nitrogen"
];
List<String> elementsWeights = [
  "1.0079",
  "4.0026",
  "6.941",
  "9.0122",
  "10.811",
  "12.0107",
  "14.0067"
];
List<String> elementsSymbol = ["H", "He", "Li", "Be", "B", "C", "N"];