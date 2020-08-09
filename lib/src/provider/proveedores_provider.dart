import 'dart:convert';

import 'package:happy/src/models/proveedor.dart';
import 'package:http/http.dart' as http;

class ProveedorProvider{

  final String _url = 'https://happy-a6611.firebaseio.com';


  Future<bool> crearProveedor(ProveedorModelo proveedorModelo) async{
    final url = '$_url/proveedores.json';
    //https://happy-a6611.firebaseio.com/proveedores.json

    final resp = await http.post(url, body: proveedorModeloToJson(proveedorModelo));

    final decodedData = json.decode(resp.body);
    print('$decodedData');

    return true;

  }
  Future<List<ProveedorModelo>> cargarProveedores() async {
    final url = '$_url/proveedores.json';

    final resp = await http.get(url);

    final Map <String, dynamic> decodeData = json.decode(resp.body);

    if(decodeData == null) return [];

    final List<ProveedorModelo> proveedores = new List(); 

    decodeData.forEach((id, prov) { 
      final provTemp = ProveedorModelo.fromJson(prov);
      provTemp.id = id;

      proveedores.add(provTemp);
    });

    return proveedores;
  }

  Future<int> borrarProveedor(String id ) async{
    final url = '$_url/proveedor/$id.json';

    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }
}