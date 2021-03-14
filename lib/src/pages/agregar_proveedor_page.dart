import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:happy/src/blocs/agregar_proveedor.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/models/servicio_model.dart';
import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:happy/src/provider/proveedores_provider.dart';
import 'package:happy/src/utils/utils.dart' as utils;

import 'package:flutter/material.dart';
import 'package:happy/src/models/global.dart';
import 'package:happy/src/blocs/provider.dart';

import '../models/global.dart';
 
// void main() => runApp(LoginPage());
 
class AgregarProveedorPage extends StatefulWidget {
  //final usuarioProvider = new UsuarioProvider();
  @override
  _AgregarProveedorPageState createState() => _AgregarProveedorPageState();
}

class _AgregarProveedorPageState extends State<AgregarProveedorPage> {
  final proveedorProvider = ProveedorProvider();

  ProveedorModelo proveedor = new ProveedorModelo();
  final _prefs = new PreferenciasUsuario();

  List<Servicio> _beneficios = Servicio.getServicios();
  List<DropdownMenuItem<Servicio>> _dropdownMenuItems;
  Servicio _beneficioSeleccionado;
 
  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies()  {
    _dropdownMenuItems = buildDropdownMenuItems(_beneficios);
    _beneficioSeleccionado = _dropdownMenuItems[0].value;
    super.didChangeDependencies();
    
  }


 
  List<DropdownMenuItem<Servicio>> buildDropdownMenuItems(List beneficios) {
    List<DropdownMenuItem<Servicio>> items = List();
    for (Servicio beneficio in beneficios) {
      items.add(
        DropdownMenuItem(
          value: beneficio,
          child: Text(beneficio.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(Servicio servicioSeleccionado) {
    setState(() {
      _beneficioSeleccionado = servicioSeleccionado;
      _prefs.userServicioSeleccionado = servicioSeleccionado.name;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _creaFondo(context),
            _agregarProveedorForm(context)

          ]
          ),
      );
  }

  Widget _agregarProveedorForm(BuildContext context){
    final bloc = Provider.agregarProveedorBlocOf(context);
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
         // Text('Agregando nuevo Proveedor ')
        
        ],
      ),
    );

  }

  Container containerWithDimension(Size size, AgregarProveedorBloc bloc, double dimensionWidth) {
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
          child: SingleChildScrollView(
            child: Column(
            
              children: <Widget>[
                //Text ('Ingreso',style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 20.0,),
                _crearNombreProveedor(bloc),
                SizedBox(height: 20.0,),
                _crearDescripcion(bloc),
                SizedBox(height: 10.0,),
                //_crearServicio(bloc),
                SizedBox(height: 10.0,),
                _crearSeleccioarServicio(bloc),
                SizedBox(height: 30.0,),
                _crearBoton(bloc)
              ],
            ),
          ),
        );
  }

  Widget _crearNombreProveedor(AgregarProveedorBloc bloc){

    return  StreamBuilder(

      stream: bloc.nombreStream,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.local_parking, color: lightGreen,),
            hintText: 'Nombre del Proveedor',
            labelText: 'Proveedor',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changeNombre,
          
        ),
      );  
      },
    );
  }

  Widget _crearDescripcion(AgregarProveedorBloc bloc){

    return  StreamBuilder(

      stream: bloc.descripcioneStream,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.description, color: lightGreen,),
            hintText: 'Descripción',
            labelText: 'Descripción del proveedor',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changeDescripcion,
        ),
      );  
      },
    );
  }

  Widget _crearServicio(AgregarProveedorBloc bloc){

    return StreamBuilder(
      stream: bloc.nombreStream,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.sentiment_very_satisfied, color: lightGreen,),
              hintText: 'Subsidio de almuerzo',
              labelText: 'Nombre de servicio',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeNombre,
          ),
          
        );
      },
    );
  }

  Widget _crearSeleccioarServicio(AgregarProveedorBloc bloc){

    return StreamBuilder(
      stream: bloc.nombreStream ,
      //initialData:   ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          //width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          margin: EdgeInsets.only(left: 40.0),
          alignment: Alignment.bottomLeft,
          //width: 20.0,
          child: DropdownButton(
            isExpanded: true,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            hint: snapshot.data,
            
            underline: Container(
              height: 2,
              color: lightGreen,
              ),
            value: _beneficioSeleccionado,
            items: _dropdownMenuItems,
            onChanged: onChangeDropdownItem, 
          ), 
        //   new DropdownButton<String>(
        //     isExpanded: true,
        //     value: selecciona, //dropdownItem[0].toString() ,
        //     icon: Icon(Icons.arrow_downward),
        //     elevation: 16,
        //     style: TextStyle(color: lightGreen),
        //     underline: Container(
        //       height: 2,
        //       color: lightGreen,
        //     ),
        //   items: dropdownItem.map((String dropdownValue) {
        //     selecciona = dropdownValue;
        //     return new DropdownMenuItem<String>(
        //       value: dropdownValue,
        //       child: new Text(dropdownValue),
        //     );
        //   }).toList(),
        //   onTap: (){
        //     setState(() {
        //       selecciona = '$selecciona';     
        //     });
        //   },
        //   onChanged: bloc.changeServicio,
          
           
        //   // TextField(
        //   //   //obscureText: true,
        //   //   keyboardType: TextInputType.emailAddress,
        //   //   decoration: InputDecoration(
        //   //     icon: Icon(Icons.sentiment_very_satisfied, color: lightGreen,),
        //   //     hintText: 'Subsidio de almuerzo',
        //   //     labelText: 'Nombre de servicio',
        //   //     counterText: snapshot.data,
        //   //     errorText: snapshot.error
        //   //   ),
        //   //   onChanged: bloc.changeServicio,
        //   // ),
        // )  
        );
      },
    );
  }

  Widget _crearBoton(AgregarProveedorBloc bloc){

    bool datos = true; 
    if(bloc.nombre == '' || bloc.descripcion == ''){
      datos = false;

    }
      
    return  StreamBuilder(
      stream: bloc.formValidStream,
      // initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){ 
        return Hero(
          tag: '  ',
          child: RaisedButton(
            
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
              child: Text('Agregando nuevo Proveedor'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black26),
            ),
            elevation: 0.5,
            color: Colors.lightGreen,
            textColor: Colors.white,
            
            onPressed: snapshot.hasData ? ()=> _agregarproveedor(bloc, context) : null 
            
        ),
        );
      },
    );
  }

  _agregarproveedor(AgregarProveedorBloc bloc, BuildContext context) async {

    // usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    if(bloc.nombre == '' || bloc.descripcion == ''){
        utils.mostrarAlertaDeError(context, "Los campos Nombre y Descripción son requeridos"); 
       // print("Nananina tingola ");
    }else {

      proveedor.id =_prefs.userServicioSeleccionado;
      proveedor.nombre = bloc.nombre;
      proveedor.descripcion = bloc.descripcion;
      proveedor.servicio = _prefs.userServicioSeleccionado;//bloc.servcio;

      //print(proveedor.toString());
      bool info =   await proveedorProvider.crearProveedor(proveedor);

      if(info){
        utils.mostrarAlerta(context, "Proveedro agreado satisfactoriamente ");
        //print("Revisa que seguardo la vaina manin ");
      }else {
        utils.mostrarAlertaDeError(context, "Error de Firebase");
        
      }

      // Navigator.pushReplacementNamed(context, 'login');

    }
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
        Text('Agregando nuevo Proveedor !!', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
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