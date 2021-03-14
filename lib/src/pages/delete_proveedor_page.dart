import 'dart:math';

import 'package:flutter/material.dart';
import 'package:happy/src/models/global.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/provider/proveedores_provider.dart';
import 'package:happy/src/utils/utils.dart' as utils;

class DeleteProveedor extends StatefulWidget {
  DeleteProveedor({Key key}) : super(key: key);

  @override
  _DeleteProveedorState createState() => _DeleteProveedorState();
}

class _DeleteProveedorState extends State<DeleteProveedor> {

  ProveedorProvider proveedorProvider = new ProveedorProvider();


 @override
  void initState(){
    super.initState();
    // running on the web!
  }


  @override
  void didChangeDependencies() async {
    final ProveedorModelo proveedor = ModalRoute.of(context).settings.arguments;
    int code = await proveedorProvider.borrarProveedor(proveedor.id_fb);
    utils.mostrarAlerta(context, "Proveedor Eliminado codigo $code de respuesta :  ${proveedor.id}");
    new Future.delayed(const Duration(seconds: 5), ()=> Navigator.of(context).pushNamed('home'));
    super.didChangeDependencies();
    
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
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: size.height * 0.2, width: double.infinity,),
          Icon(Icons.delete_forever, color: Colors.white, size: 80.0,),
          // SizedBox(height: size.height * 0.2, width: double.infinity,),
          Text('Registro Eliminado', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
        ],),
      ),
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