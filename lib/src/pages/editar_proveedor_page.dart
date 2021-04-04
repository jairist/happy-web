import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy/src/blocs/agregar_proveedor.dart';
import 'package:happy/src/blocs/provider.dart';
import 'package:happy/src/models/evaluacion_model.dart';
import 'package:happy/src/models/global.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/models/servicio_model.dart';
import 'package:happy/src/provider/evaluacion_provider.dart';
import 'package:happy/src/provider/proveedores_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:happy/src/widgets/totales_piechart_widget.dart';
import 'package:happy/src/utils/utils.dart' as utils;

class EditarProveedor extends StatefulWidget {

  @override
  _EditarProveedorState createState() => _EditarProveedorState();
}

class _EditarProveedorState extends State<EditarProveedor> {

  List<Servicio> _beneficios = Servicio.getServicios();
  List<DropdownMenuItem<Servicio>> _dropdownMenuItems;
  Servicio _beneficioSeleccionado;
  String _servicioSeleccionado;
  var nombre = TextEditingController();
  var descipcion = TextEditingController();
  
  final proveedorProvider = ProveedorProvider();
  

   @override
  void initState() {
  
    super.initState();
  }
  @override
  void didChangeDependencies() {
    int temp = 0;
    int posicion = 0;
    
    final ProveedorModelo proveedor = ModalRoute.of(context).settings.arguments;
    List<Servicio> beneficios = Servicio.getServicios();
    _dropdownMenuItems = buildDropdownMenuItems(_beneficios);
    for (Servicio beneficio in beneficios) {
      if(beneficio.name == proveedor.servicio){
        posicion = temp;
        
      }
      temp++;
      }

    _beneficioSeleccionado = _dropdownMenuItems[posicion].value;
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
      _servicioSeleccionado = servicioSeleccionado.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProveedorModelo proveedor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: buildAppBar(context, proveedor),
      body: Stack(
            children: <Widget>[
              _creaFondo(context),
              _editarProveedorForm(context, proveedor)

            ]
          ),
    );
  }
    AppBar buildAppBar(BuildContext context, ProveedorModelo proveedor) {
    return AppBar(
      automaticallyImplyLeading:
          MediaQuery.of(context).size.width < 1300 ? true : false,
           leading: IconButton(
            tooltip: 'Volver atras',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pushNamed('home');
            },
          ),
      title:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 32),
              child: Text(
                "Editando al proveedor Proveedor '${proveedor.nombre}' ",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'HelveticaNeue',
                ),
              ),
            ),
          ]),
          actions: <Widget>[
            SizedBox(width: 32),
            Container(
              child: IconButton(
                tooltip: 'Dashboard',
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.web),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'home');
                },
              ),          
            ),
            //SizedBox(width: 32),
            //Container(child: Icon(Icons.account_circle)),
            Container(
              child: IconButton(
                tooltip: 'Salir',
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
              ),
            ),
            SizedBox(width: 32),
          ],
      );
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
        Text('Editando Proveedor ', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
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

  Widget _editarProveedorForm(BuildContext context, ProveedorModelo proveedor){
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
          containerWithDimension(size, bloc, dimensionWidth, proveedor)
          ,
         // Text('Agregando nuevo Proveedor ')
        
        ],
      ),
    );

  }

  Container containerWithDimension(Size size, AgregarProveedorBloc bloc, double dimensionWidth, ProveedorModelo proveedor) {
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
              _crearNombreProveedor(bloc, proveedor),
              SizedBox(height: 20.0,),
              _crearDescripcion(bloc, proveedor),
              SizedBox(height: 10.0,),
              //_crearServicio(bloc),
              SizedBox(height: 10.0,),
              _crearSeleccioarServicio(bloc, proveedor),
              SizedBox(height: 30.0,),
              _crearBoton(bloc, proveedor)
            ],
          ),
        );
  }

  Widget _crearNombreProveedor(AgregarProveedorBloc bloc, ProveedorModelo proveedor){
    
    nombre.text = proveedor.nombre.toString();
    //bloc.nombre = proveedor.nombre.toString();

    return  StreamBuilder(

      stream: bloc.nombreStream,
      initialData: proveedor.nombre,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: nombre,
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

  Widget _crearDescripcion(AgregarProveedorBloc bloc, ProveedorModelo proveedor){
    descipcion.text = proveedor.descripcion.toString();

    return  StreamBuilder(

      stream: bloc.descripcioneStream,
      initialData: proveedor.descripcion ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: descipcion,
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

  Widget _crearSeleccioarServicio(AgregarProveedorBloc bloc, ProveedorModelo proveedor){

    return StreamBuilder(
      stream: bloc.nombreStream ,
      //initialData: proveedor.servicio ,
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
        );
      },
    );
  }

  Widget _crearBoton(AgregarProveedorBloc bloc, ProveedorModelo proveedor){

    bool datos = true; 
    if(proveedor.nombre == '' || proveedor.descripcion == ''){
      datos = false;

    }
      
    return  StreamBuilder(
      stream: bloc.formValidStream,
      //initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot){ 
        return Hero(
          tag: '  ',
          child: RaisedButton(

            
            child: Container(
              
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
              child: Text('Guardar Cambios'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black26),
            ),
            elevation: 0.5,
            color: Colors.lightGreen,
            textColor: Colors.white,

            
            onPressed: ()=> _agregarproveedor(bloc, context, proveedor)
            
        ),
        );
      },
    );
  }


  _agregarproveedor(AgregarProveedorBloc bloc, BuildContext context, ProveedorModelo proveedor) async {


    if(bloc.nombre == '' || bloc.descripcion == ''){
        utils.mostrarAlertaDeError(context, "Los campos Nombre y Descripción son requeridos"); 
       // print("Nananina tingola ");
    }else {
      if (_servicioSeleccionado != null ){
         //utils.mostrarAlerta(context, "No hay servicio seleccionado");
          proveedor.servicio = _servicioSeleccionado.toString();//bloc.servcio;
          proveedor.id = _servicioSeleccionado.toString();
      }
        proveedor.nombre = nombre.text.toString();
        proveedor.descripcion = descipcion.text.toString();
    
        bool info =   await proveedorProvider.editarProveedor(proveedor);

        
      if(info){
        utils.mostrarAlertaParaEditarProveedor(context, "Proveedor ${proveedor.nombre} editado satisfactoriamente ");
        //print("Revisa que seguardo la vaina manin ");
      }else {
        utils.mostrarAlertaDeError(context, "Error de Firebase");
        
      }

    }
  } 



}