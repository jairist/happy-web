import 'dart:convert';

import 'dart:io';

import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:happy/src/models/evaluacion_model.dart';
import 'package:mime_type/mime_type.dart';

class EvaluacionProvider{

  final String _url = 'https://happy-a6611.firebaseio.com';
  final _prefs = new PreferenciasUsuario();


  Future<bool> crearEvaluacion(EvaluacionModelo evaluacionModelo) async{
    final url = '$_url/evaluaciones.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: evaluacionModeloToJson(evaluacionModelo));

    final decodedData = json.decode(resp.body);
    print('$decodedData');

    return true;

  }
  Future<bool> editarEvaluacion( EvaluacionModelo evaluacion ) async {
    final url = '$_url/evaluaciones/${ evaluacion.id }.json?auth=${_prefs.token}';
    final resp = await http.put( url, body: evaluacionModeloToJson(evaluacion) );
    final decodedData = json.decode(resp.body);
    print( decodedData );

    return true;

  }

  Future<List<EvaluacionModelo>> cargarEvaluaciones() async {

    final url  = '$_url/evaluaciones.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<EvaluacionModelo> evaluaciones = new List();

    if ( decodedData == null ) return [];

    decodedData.forEach( ( id, prod ){

      final prodTemp = EvaluacionModelo.fromJson(prod);
      prodTemp.id = id;

      evaluaciones.add( prodTemp );

    });

    print('$decodedData');
    return evaluaciones;
  }

  //   Future<List<EvaluacionModelo>> cargarTop10Evaluaciones() async {

  //   final url  = '$_url/evaluaciones.json?auth=${_prefs.token}';
  //   // 'https://dinosaur-facts.firebaseio.com/dinosaurs.json?orderBy="weight"&limitToLast=2&print=pretty'
  //   final resp = await http.get(url);

  //   final Map<String, dynamic> decodedData = json.decode(resp.body);
  //   final List<EvaluacionModelo> evaluaciones = new List();

  //   if ( decodedData == null ) return [];

  //   decodedData.forEach( ( id, prod ){

  //     final prodTemp = EvaluacionModelo.fromJson(prod);
  //     print(prodTemp);
  //     prodTemp.id = id;

  //      print('$decodedData');

  //   });

  //   print( evaluaciones[0].id );
  //   return evaluaciones;
  // }

  Future<int> totalEvaluaciones() async {

     final url  = '$_url/evaluaciones.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if ( decodedData == null ) return 0;

    print("Total Evaluaciones " + decodedData.length.toString());

    return decodedData.length;
  }


  Future<int> borrarEvaluacion( String id ) async { 

    final url  = '$_url/evaluaciones/$id.json?auth=${_prefs.token}';

    final resp = await http.delete(url);
    

    print( resp.body );

    return 1;
  }

  
  Future<String> obtenerUserName( String id ) async { 

    final url  = '$_url/evaluaciones/$id.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final userName = decodedData['user'];

    print( resp.body );

    return userName;
  }

  Future<String> subirImagen(File imagen) async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/do0twoors/image/upload?upload_preset=b9rkz6i4');
    final mimeType =  mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path, 
      contentType: MediaType( mimeType[0], mimeType[1])
      );

      imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];

  }
}