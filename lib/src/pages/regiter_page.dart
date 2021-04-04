import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:happy/src/utils/utils.dart' as utils;

import 'package:flutter/material.dart';
import 'package:happy/src/models/global.dart';
import 'package:happy/src/blocs/provider.dart';
import 'package:happy/src/provider/usuario_provider.dart';

import '../models/global.dart';
 
// void main() => runApp(LoginPage());
 
class RegisterPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();
  final _prefs = new PreferenciasUsuario();
  var usuarioController = TextEditingController();
  var emailController = TextEditingController();
  var claveCotroller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _creaFondo(context),
            _registerForm(context)

          ]
          ),
      );
  }

  Widget _registerForm(BuildContext context){
    final bloc = Provider.registerBlocOf(context);
    final size = MediaQuery.of(context).size;
    var dimensionWidth = 0.85;

    if(kIsWeb){
      dimensionWidth = 0.39;
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          containerWithDimension(size, bloc, dimensionWidth)
          ,
           TextButton(child:  Text('Ya tienes cuenta ? Login'),
              onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox( height: 50.0 )
        
        ],
      ),
    );

  }

  Container containerWithDimension(Size size, RegisterBloc bloc, double dimensionWidth) {
    return Container(
          width: size.width * dimensionWidth,
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
              //Text ('Ingreso',style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 20.0,),
              _crearNombreUsuario(bloc),
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

  Widget _crearNombreUsuario(RegisterBloc bloc){

    usuarioController.text = '';

    return  StreamBuilder(

      stream: bloc.userNameStream,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: usuarioController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.account_circle, color: lightGreen,),
            hintText: 'Nombre de usuario',
            labelText: 'Usuario',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changeUserName,
        ),
      );  
      },
    );
  }
  Widget _crearEmail(RegisterBloc bloc){

    emailController.text = '';

    return  StreamBuilder(

      stream: bloc.emailStream,
      initialData: '' ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: emailController,
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

  Widget _crearPassword(RegisterBloc bloc){
    claveCotroller.text = '';

    return StreamBuilder(
      stream: bloc.passwordStream ,
      initialData: '' ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            controller: claveCotroller,
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

  Widget _crearBoton(RegisterBloc bloc){

    return  StreamBuilder(
      
      stream: bloc.formValidStream,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){ 
        return Hero(
          tag: '  ',
          child: RaisedButton(
            
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
              child: Text('Enviar Link'),


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
  _register(RegisterBloc bloc, BuildContext context) async {

    // usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    Map info =   await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    if(info['ok']){
      _prefs.userName = bloc.userName.toString();
      Map info =   await usuarioProvider.resetearClave(bloc.email);
      utils.mostrarAlertaParaEditarProveedor(context, 'Un correo ha sido enviado al usuario ${bloc.email} para que puede colocar su contraseña');
      //Navigator.pushReplacementNamed(context, 'login');
    }else {
      utils.mostrarAlertaDeError(context, info['mensaje']);
    }
    //bloc.emailStream = '';

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
        Text('Registro !!', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
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