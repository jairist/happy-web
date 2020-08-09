import 'dart:convert';

import 'package:happy/src/pages/resetear_clave.dart';
import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider{
  final String _firebaseToken = 'AIzaSyAfFXzRzkUFsEf28qFo0iI8Iw3jyQLd0aw';
  final _prefs = new PreferenciasUsuario();


  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email'     :email,
      'password'  :password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken') ){
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token':decodedResp['idToken']};
    }else{
      return {'ok':false, 'mensaje': decodedResp['error']['message']};
    }

  }

  Future<Map<String, dynamic>>nuevoUsuario(String email, String password) async {
    final authData = {
      'email'     :email,
      'password'  :password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken') ){
      //TODO: salvar el token en el storage
      return {'ok': true, 'token':decodedResp['idToken']};
    }else{
      return {'ok':false, 'mensaje': decodedResp['error']['message']};
    }

  }


  Future<Map<String, dynamic>>resetearClave(String email,) async {
    final authData = {
      'requestType':'PASSWORD_RESET',
      'email':email,
    };

    //https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=[API_KEY]

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('email') ){
      //TODO: salvar el token en el storage
      return {'ok': true, 'email':decodedResp['email']};
    }else{
      return {'ok':false, 'mensaje': decodedResp['error']['message']};
    }

  }

}