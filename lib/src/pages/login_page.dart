import 'dart:math';

import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:happy/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:happy/src/models/global.dart';
import 'package:happy/src/blocs/login_bloc.dart';
import 'package:happy/src/blocs/provider.dart';
import 'package:happy/src/provider/usuario_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../models/global.dart';
 
// void main() => runApp(LoginPage());
 
class LoginPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();
  final _prefs = new PreferenciasUsuario();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _creaFondo(context),
            _loginForm(context)

          ]
          ),
      );
  }

  Widget _loginForm(BuildContext context){
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    var dimesionWidth = 0.85;
    
    if(kIsWeb){
      dimesionWidth = 0.39;
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          contanierWithdDimension(size, bloc, dimesionWidth),
          FlatButton(child:  Text('Olvidó su contraseña?'),
              onPressed: ()=> Navigator.pushReplacementNamed(context, 'resetear'),
          ),
         FlatButton(child:  Text('Crear una nueva cuenta'),
              onPressed: ()=> Navigator.pushReplacementNamed(context, 'registro'),
          ),
          SizedBox( height: 50.0 )
        
        ],
      ),
    );

  }

  Container contanierWithdDimension(Size size, LoginBloc bloc, double dimesionWidth) {

      return Container(
          width: size.width * dimesionWidth,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0, ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Text ('Ingreso',style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 20.0,),
              _crearEmail(bloc),
              SizedBox(height: 10.0,),
              _crearPassword(bloc),
              SizedBox(height: 30.0,),
              _crearBoton(bloc)
            ],
          ),
        );
  }

  Widget _crearEmail(LoginBloc bloc){

    return  StreamBuilder(

      stream: bloc.emailStream,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.alternate_email, color: lightGreen,),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electrónico',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changeEmail,
        ),
      );  
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordStream ,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            // keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: lightGreen,),
              // hintText: 'ejemplo@correo.com',
              labelText: 'Contraseña',
              // counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
          
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc){

    return  StreamBuilder(
      
      stream: bloc.formValidStream,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){ 
        return Hero(
          tag: 'login',
          child: RaisedButton(
            
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black26),
            ),
            elevation: 0.5,
            color: Colors.lightGreen,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? ()=> _register(bloc, context) : null
          ),
        );
      },
    );
  }

    _register(LoginBloc bloc, BuildContext context) async {

      // usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

      Map info =   await usuarioProvider.login(bloc.email, bloc.password);

      if(info['ok']){
        Navigator.pushReplacementNamed(context, 'home');
        

      }else if(info['mensaje'].toString().contains('EMAIL_NOT_FOUND') ){
          utils.mostrarAlertaParaRegistro(context);

      }else{
        utils.mostrarAlerta(context, 'Email o clave incorrecta, en caso de no recordar la clave, puedes resetearla' );

      }

      // Navigator.pushReplacementNamed(context, 'login');

  }

  Widget _creaFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final randomNumber = Random();

    final fondo = Container(
      height: size.height * 0.4,
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
        Icon(Icons.sentiment_very_satisfied, color: Colors.white, size: 80.0,),
        SizedBox(height: 10.0, width: double.infinity,),
        Text( 'Acceder', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
      ],),
    );
    
    return Stack(
      children: <Widget>[
        fondo,
        Positioned( top: randomNumber.nextInt(10).toDouble(), left: randomNumber.nextInt(40).toDouble(), child: circulo,),
        Positioned( top: randomNumber.nextInt(80).toDouble(), right: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(10).toDouble(), right: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(110).toDouble(), right: -randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( top: randomNumber.nextInt(90).toDouble(), left: randomNumber.nextInt(120).toDouble(), child: circulo,),
        Positioned( bottom: randomNumber.nextInt(120).toDouble(), left: randomNumber.nextInt(120).toDouble(), child: circulo,),

        nombreUsuario
      ],
    );

  }
}