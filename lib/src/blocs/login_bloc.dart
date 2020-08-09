import 'dart:async';

import 'package:happy/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  //declarando los stream controllers para manejar el flujo de lainformacion en los campos 

  final _emailController        = BehaviorSubject<String>();
  final _passwordsController    = BehaviorSubject<String>();
  // final _userNameController    = BehaviorSubject<String>();

  //Recuperar los datos del Stream 
  Stream<String> get emailStream       => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream    => _passwordsController.stream.transform(validarPassword);
  // Stream<String> get userNameStream    => _userNameController.stream.transform(validarUserName);

  Stream<bool> get formValidStream =>
    CombineLatestStream.combine2(emailStream, passwordStream,  (e, p) => true);
  
  Stream<bool> get formEmailStream =>
    CombineLatestStream. combine2(emailStream, emailStream,  (e,a) => true);

  //inser valores en el Stream 
  Function(String) get changeEmail      => _emailController.sink.add;
  Function(String) get changePassword   => _passwordsController.sink.add;
  // Function(String) get changeUserName   => _userNameController.sink.add;

  //obtener el útimo valor ingresado a los streams 
  String get email      => _emailController.value;
  String get password   => _passwordsController.value;
  // String get userName   => _userNameController.value;
  
  //siempre liberar el stream luego de usarlo

  dispose(){
    _passwordsController?.close();
    _emailController?.close();
    // _userNameController?.close();
  }

}