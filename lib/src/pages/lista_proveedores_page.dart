import 'package:flutter/material.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/provider/proveedores_provider.dart';

class ListaProveedores extends StatelessWidget {

  final proveedorProvider = new ProveedorProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _crearListado(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: ()=> Navigator.pushNamed(context, 'home')),
    );
  }
  Widget _crearListado() {
    return FutureBuilder(
      future: proveedorProvider.cargarProveedores(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<ProveedorModelo>> snapshot) {
        if(snapshot.hasData){
          final proveedores = snapshot.data;         
          return Container(
            child: ListView.builder(
              itemCount:proveedores.length,
              itemBuilder: (context, i) => _crearItem(proveedores[i], context),
              
              ),
          );
        }else {
          
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(ProveedorModelo proveedor, BuildContext context) {
    return Container(
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color:Colors.red
        ),
        onDismissed: (direccion){
          //TODO: Borrar proveedor
          proveedorProvider.borrarProveedor(proveedor.id);
          print(proveedor.id);
        },
        child: ListTile(
          title: Text(proveedor.nombre??"Nombre"),
          subtitle: Text(proveedor.descripcion??"Descripcion"),
          onTap: ()=> Navigator.pushNamed(context, 'register'),
          

        ),
      ),
    );

  }
}