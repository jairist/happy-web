import 'dart:async';

class Validators {

  //siempres e debe indentificar ue es lo que entra y qeu es lo que sale del flujo por eso <String, String>
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      //si el password introducido es mayor a 6 entonces lo dejo fluir de lo contrario no. 
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);

      }else{
        sink.addError('Email no es correcto');
      }

    }

  );
  //siempres e debe indentificar ue es lo que entra y qeu es lo que sale del flujo por eso <String, String>
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){

      //si el password introducido es mayor a 6 entonces lo dejo fluir de lo contrario no. 
      if(password.length >= 6){
        sink.add(password);

      }else{
        sink.addError('Más de 6 carácteres por favor');
      }
    }
  );
    final validarUserName = StreamTransformer<String, String>.fromHandlers(
    handleData: (username, sink){

      //si el password introducido es mayor a 6 entonces lo dejo fluir de lo contrario no. 
      if(username.length >= 5){
        sink.add(username);

      }else{
        sink.addError('Más de 5 carácteres por favor ');
      }
    }
    );

    final validarNombreProveedor = StreamTransformer<String, String>.fromHandlers(
    handleData: (nombre, sink){

      //si el password introducido es mayor a 6 entonces lo dejo fluir de lo contrario no. 
      if(nombre.length >= 4){
        sink.add(nombre);

      }else{
        sink.addError('Más de 4 carácteres por favor');
      }
    }

  );
  final validarServicioProveedor = StreamTransformer<String, String>.fromHandlers(
    handleData: (servcio, sink){

      //si el password introducido es mayor a 6 entonces lo dejo fluir de lo contrario no. 
      if(servcio.length >= 4 && !servcio.contains(' ')){
        sink.add(servcio);

      }else{
        sink.addError('Más de 4 carácteres por favor y no debe contener espacios en blanco');
      }
    }

  );
  final validarDescripcionProveedor = StreamTransformer<String, String>.fromHandlers(
    handleData: (servcio, sink){

      //si el password introducido es mayor a 6 entonces lo dejo fluir de lo contrario no. 
      if(servcio.length >= 2 ){
        sink.add(servcio);

      }else{
        sink.addError('Más de 4 carácteres por favor y no debe contener espacios en blanco');
      }
    }

  );
}