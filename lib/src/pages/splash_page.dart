import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:happy/src/models/global.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class GraciasPage extends StatefulWidget {
  const GraciasPage({Key key}) : super(key: key);

  @override
  _GraciasPageState createState() => _GraciasPageState();
}

class _GraciasPageState extends State<GraciasPage> {

  @override
  void initState(){
    super.initState();
    if (kIsWeb) {
    // running on the web!
      new Future.delayed(const Duration(seconds: 2), ()=> Navigator.of(context).pushNamed('login'));
      } else {
    // NOT running on the web! You can check for additional platforms here.
      new Future.delayed(const Duration(seconds: 5), ()=> Navigator.of(context).pushNamed('home'));
      }
    
  }
 


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: _crearfondo(context),
        
      )
    );
  }

    Widget _crearfondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final randomNumber = Random();

    final fondo = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            lightBlueIsh, lightGreen
          ]
        )
      ),

    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.09)
      ),
    );
    final nombreUsuario = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(children: <Widget>[
        SizedBox(height: size.height * 0.2, width: double.infinity,),
        Icon(Icons.sentiment_very_satisfied, color: Colors.white, size: 80.0,),
        // SizedBox(height: size.height * 0.2, width: double.infinity,),
        Text('Muchas gracias', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
      ],),
    );
    
    return Stack(
      children: <Widget>[
        fondo,
        Positioned( top: randomNumber.nextInt(10).toDouble(), left: randomNumber.nextInt(40).toDouble(), child: circulo,),
        Positioned( top: randomNumber.nextInt(80).toDouble(), right: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(10).toDouble(), right: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(110).toDouble(), right: -randomNumber.nextInt(20).toDouble(), child: circulo,),
        Positioned( top: randomNumber.nextInt(90).toDouble(), left: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(120).toDouble(), left: randomNumber.nextInt(30).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(120).toDouble(), left: randomNumber.nextInt(300).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(110).toDouble(), left: randomNumber.nextInt(40).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(20).toDouble(), left: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(60).toDouble(), left: randomNumber.nextInt(30).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(40).toDouble(), left: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(30).toDouble(), left: randomNumber.nextInt(120).toDouble(), child: circulo,),

        nombreUsuario
      ],
    );

  }
}