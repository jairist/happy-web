import 'dart:math';

import 'package:flutter/material.dart';
import 'package:happy/src/models/global.dart';

import '../models/global.dart';
import '../models/global.dart';
import '../models/global.dart';

void main() => runApp(HomeAlternativo());


class HomeAlternativo extends StatefulWidget {

  @override
  _HomeAlternativo createState() => _HomeAlternativo();
}

class _HomeAlternativo extends State<HomeAlternativo> {

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(  
              children: <Widget>[
                Column(             
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _crearTitulo(),
                      Container(
                        height: 600,
                        margin: EdgeInsets.only(top: 200.0, bottom: 10.0),
                        padding: EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                // height:  size.height * 0.6,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: _getServiceBox(),
                                ),
                              ),
                            ), 
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }

  Widget _crearTitulo(){
    final size = MediaQuery.of(context).size;
    final randomNumber = Random();

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.09)
      ),
    );

    final fondo = Container(
      padding: EdgeInsets.all(30),
              constraints: BoxConstraints.expand(height: 200),
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
    );
    final titulo =   Container(    
          padding: EdgeInsets.only(top: 40.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Hola Jairis Rosario!!', style: titleStyleWhite,),
              Text('Selecciona el servicio a evaluar', style: titleStyleWhite,)
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
  List<String> services = ["Comida", "Transporte", "Salud", "Educacion", "Finance"];

  Map servicioToIcon = {
    "Comida" : Icon(Icons.fastfood, color: lightBlueIsh, size: 50,),
    "Transporte" : Icon(Icons.directions_car, color: lightBlueIsh, size: 50),
    "Salud" : Icon(Icons.healing, color: lightBlueIsh, size: 50),
    "Educacion" : Icon(Icons.book, color: lightBlueIsh, size: 50),
    "Finance" : Icon(Icons.card_membership, color: lightBlueIsh, size: 50),
  };

  Widget _getServiceContainer(String categoryName) {
    return  Container(
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
          height: 180,
          width: 140,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                
                color: Colors.grey,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Text(categoryName, style: titileStyleLighterBlack),
              Container(
                padding: EdgeInsets.only(top: 30),
                height: 100,
                width: 80,
                child: FloatingActionButton(
                  heroTag: categoryName,
                  backgroundColor: Colors.white,
                  child:  servicioToIcon[categoryName],
                  elevation: 20,
                  onPressed: () {
                    Navigator.of(context).pushNamed('evaluar', arguments: categoryName);
                    // Navigator.pushNamed(context, 'detalle', arguments: pelicula );
                    print('Se presiono sobre $categoryName');

                  },
                ),
              )
            ],
          ),
        );
  }

  List<Widget> _getServiceBox() {
    List<Widget> servicesCards = [];
    List<Widget> rows = [];
    int i = 0;
    for (String category in services) {
      if (i < 2) {
        rows.add(_getServiceContainer(category));
        i ++;
      } else {
        i = 0;
        servicesCards.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ));
        rows = [];
        rows.add(_getServiceContainer(category));
        i++;
      }
    }
    if (rows.length > 0) {
      servicesCards.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ));
    }
    return servicesCards;
  }
}