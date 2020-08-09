import 'dart:math';

import 'package:flutter/material.dart';
import 'package:happy/src/models/global.dart';

class HeaderPage extends StatelessWidget {
  
  final String servicio;

  HeaderPage({ @required this.servicio });

  @override
  Widget build(BuildContext context) {
    return _crearTitulo();
  }
    Widget _crearTitulo(){
    // final size = MediaQuery.of(context).size;
    final randomNumber = Random();

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.09)
      ),
    );

    final fondo = SafeArea( 
      child : Container(
      padding: EdgeInsets.all(30),
              constraints: BoxConstraints.expand(height: 150),
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [lightBlueIsh, lightGreen],
                  begin: const FractionalOffset(1.0, 1.0),
                  end: const FractionalOffset(0.2, 0.2),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30))
              )
    ));
    final titulo =   Container(    
          padding: EdgeInsets.only(top: 40.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Evaluación !!', style: titleStyleWhite,),
              Text('Que tál estuvo servicio de :  $servicio ?', style: titleStyleWhite,)
            ],
          ),
        
            );

  return Stack(
    children: <Widget>[
      fondo,
      Positioned( top: randomNumber.nextInt(10).toDouble(), left: randomNumber.nextInt(40).toDouble(), child: circulo,),
      Positioned( top: randomNumber.nextInt(10).toDouble(), left: randomNumber.nextInt(40).toDouble(), child: circulo,),
      Positioned( top: randomNumber.nextInt(80).toDouble(), right: randomNumber.nextInt(120).toDouble(), child: circulo,),
      Positioned( bottom: randomNumber.nextInt(10).toDouble(), right: randomNumber.nextInt(120).toDouble(), child: circulo,),
      Positioned( bottom: randomNumber.nextInt(110).toDouble(), right: -randomNumber.nextInt(120).toDouble(), child: circulo,),
      titulo
    ],
  );

  }
}