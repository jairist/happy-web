import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:happy/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.registerBlocOf(context);
    // final userName = bloc.

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(bloc),
                _botonesRedondeados()
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: _buttomNavigationBar(context)
    );
  }

  Widget _fondoApp() {
    final gradiente  = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [ 
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
            // Color.fromRGBO(000, 000, 000, 1.0),
            // Color.fromRGBO(000, 000, 000, 1.0),
          ]
        )
      ),
    );

    final caja = Transform.rotate(
      angle: -pi / 4.0,
      child:  Container(
      height: 360.0,
      width: 360.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        gradient: LinearGradient(
          colors: [

            Colors.lightBlueAccent,
            Colors.blueAccent

          ]
        )
      ),
    ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100,
          child: caja,
        )

      ],
    );
  }

  Widget _titulos(RegisterBloc bloc ) {
    return Container(
      padding: EdgeInsets.all(30.0),
      
      

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: <Widget>[
          Text('Bienvenido a Happy!', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight:  FontWeight.bold),),
          SizedBox(height: 5.0,),
          Text('${bloc.userName}', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight:  FontWeight.w600, fontStyle: FontStyle.italic ),),
          SizedBox(height: 10.0,),
          Text('Selecciona el servio a evaluar.', style: TextStyle(color: Colors.white,)),
        ],
      ),
    );
  }

  Widget _buttomNavigationBar(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(35, 37, 57, 1.0),
          // Color.fromRGBO(52, 84, 181, 1.0),
            // Color.fromRGBO(35, 37, 57, 1.0),
        primaryColor: Colors.orangeAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle(color: Color.fromRGBO(116, 117, 155, 1.0))
        )

      ),
      child: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0,),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart, size: 30.0,),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, size: 30.0,),
            title: Container()
          )
        ],
      ),
    );
  }

  Widget _botonesRedondeados() {

    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeados(Colors.red, Icons.fastfood, 'Almuerzo'),
            _crearBotonRedondeados(Colors.orangeAccent, Icons.directions_bus, 'Transporte'),
          ] 
        ),
        TableRow(
          children: [
            _crearBotonRedondeados(Colors.yellowAccent, Icons.games, 'Juegos'),
            _crearBotonRedondeados(Colors.greenAccent, Icons.local_gas_station, 'Combustible'),
          ] 
        ),
        TableRow(
          children: [
            _crearBotonRedondeados(Colors.lightBlueAccent, Icons.healing, 'Salud'),
            _crearBotonRedondeados(Colors.lightGreenAccent, Icons.laptop_mac, 'Laptop'),
          ] 
        ),
      ],
    );
  }

  Widget _crearBotonRedondeados(Color color, IconData icono, String data){


    return GestureDetector(
      onTap: (){
        print('tap sobre el objeto $data');
      },
      child: ClipRect(
        
        child: BackdropFilter(
          
          
          filter: ImageFilter.blur(sigmaX: 1.9, sigmaY: 1.9),
          child: Container(

                 
            height: 180.0,
            margin: EdgeInsets.all(13.0),
            
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(15.0),
              color: Color.fromRGBO(62, 66, 107, 0.7)
              // Color.fromRGBO(35, 37, 57, 1.0) 
              // Color.fromRGBO(255, 255, 255, 0.9)
            ),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircleAvatar(
                  
                  
                  backgroundColor: Colors.white10,
                  radius: 45.0,
                  child: Icon(icono , size: 45.0, color: color, ),
                ),
                
                Text('$data', style: TextStyle( color: Colors.white),),
                
              ],
            ),
          ),
        ),
      ),
    );
  }


}