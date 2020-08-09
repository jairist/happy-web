import 'dart:async';

import 'package:happy/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class AgregarProveedorBloc with Validators{

  //declarando los stream controllers para manejar el flujo de lainformacion en los campos 

  final _nombreController        = BehaviorSubject<String>();
  final _servicioController    = BehaviorSubject<String>();
  final _descripcionController    = BehaviorSubject<String>();

  //Recuperar los datos del Stream 
  Stream<String> get nombreStream       => _nombreController.stream.transform(validarNombreProveedor);
  Stream<String> get servcioStream    => _servicioController.stream.transform(validarServicioProveedor);
  Stream<String> get descripcioneStream    => _descripcionController.stream.transform(validarDescripcionProveedor);

  Stream<bool> get formValidStream =>
    CombineLatestStream.combine3(nombreStream, servcioStream, descripcioneStream,  (e, p, u) => true);

  //inser valores en el Stream 
  Function(String) get changeNombre      => _nombreController.sink.add;
  Function(String) get changeServicio   => _servicioController.sink.add;
  Function(String) get changeDescripcion  => _descripcionController.sink.add;

  //obtener el útimo valor ingresado a los streams 
  String get nombre      => _nombreController.value;
  String get servcio      => _servicioController.value;
  String get descripcion  => _descripcionController.value;
  
  //siempre liberar el stream luego de usarlo

  dispose(){
    _nombreController?.close();
    _servicioController?.close();
    _descripcionController?.close();
  }





}