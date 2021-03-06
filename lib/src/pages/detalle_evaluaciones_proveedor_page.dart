import 'package:flutter/material.dart';
import 'package:happy/src/models/evaluacion_model.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/provider/evaluacion_provider.dart';
import 'package:happy/src/provider/proveedores_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:happy/src/widgets/totales_piechart_widget.dart';
import 'package:happy/src/utils/utils.dart' as utils;
import 'package:intl/intl.dart';

class DetalleEvaluacionesProveedor extends StatefulWidget {

  @override
  _DetalleEvaluacionesProveedorState createState() => _DetalleEvaluacionesProveedorState();
}

class _DetalleEvaluacionesProveedorState extends State<DetalleEvaluacionesProveedor> {

  bool loading = false;
  EvaluacionProvider evaluacion = new EvaluacionProvider();
  ProveedorProvider proveedorProvider = new ProveedorProvider();
  List<EvaluacionModelo> evaluaciones; 
  List<EvaluacionModelo> evaluacionPorServicio;
  List<EvaluacioneServicioSeries> data;
  double totalEvaluaciones = 0;
  double cantidadEnNivel1 = 0;
  double cantidadEnNivel2 = 0;
  double cantidadEnNivel3 = 0;
  double cantidadEnNivel4 = 0;
  double cantidadEnNivel5 = 0;
  int porcientoNivel1 = 0;
  int porcientoNivel2 = 0;
  int porcientoNivel3 = 0;
  int porcientoNivel4 = 0;
  int porcientoNivel5 = 0;

  ScrollController _controller;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies() async{
   // TODO: implement initState
   _controller = ScrollController();
    final ProveedorModelo proveedor = ModalRoute.of(context).settings.arguments;
    List<EvaluacionModelo> evaluaciones = await evaluacion.cargarComentarios(proveedor.nombre);

    if(evaluaciones.isEmpty){
     utils.mostrarAlertaProveedorSinEvaluaciones(context, 'El proveedor ${proveedor.nombre} no cuenta con evaluaciones disponibles, aún..');
    }

    super.didChangeDependencies();
    
  }
  
  // EN EL BODY VA UN SCROLL LIST
  @override
  Widget build(BuildContext context) {
    final ProveedorModelo proveedor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: buildAppBar(context, proveedor),
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  _construirGraficoDistribucionSolo(context, proveedor),
                  //_construirGraficoTotalesSolo(proveedor),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    //olor: Colors.red,
                    child: comentariosWidget(proveedor.nombre),
                    
                  ),
                ],
              ),

              ),
          ),
        ],
      ) 
    );
  }

  Container _construirGraficoDistribucionSolo(BuildContext context, ProveedorModelo proveedor) {
    return Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        //color: Colors.black,
        child:  Container(
          child: FutureBuilder <List<EvaluacioneServicioSeries>>(
            future: cargarDataParaTotalPorServicio(proveedor.nombre),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child:_construirGraficoDistribucion(snapshot.data)
                  );
              }else {
                return  Center(child: CircularProgressIndicator( backgroundColor: Colors.greenAccent,),);
              }
            }
          ),
        ),
      );
  }


  Widget _construirDetalle(BuildContext context, ProveedorModelo proveedor){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
     //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _construirGraficoTotalesSolo(proveedor),
            Expanded(
              child: FutureBuilder <List<EvaluacioneServicioSeries>>(
                future: cargarDataParaTotalPorServicio(proveedor.nombre),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                     return Container(
                        child:_construirGraficoDistribucion(snapshot.data)
                      );
                  }else {
                    return  Center(child: CircularProgressIndicator( backgroundColor: Colors.greenAccent,),);
                  }
                }
              ),
            ),
          ],  
        ),
      ],
      
    );
    
  }

  Container _construirGraficoTotalesSolo(ProveedorModelo proveedor) {
    return Container(
       height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: FutureBuilder <List<EvaluacioneServicioSeries>>(
          future: cargarDataParaTotalPorServicio(proveedor.nombre),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
              
              return  Center(
                child: CircularProgressIndicator( backgroundColor: Colors.greenAccent,)
                ,);
              
            }else {
                  return Container(
                  child:_construirGraficoTotales(snapshot.data)
                );
            }
          }
        ),
      ),
    );
  }
  Widget comentariosWidget(String nombreProveedor) {
    return Card( 
     elevation: 5,
        child: Container(
         
          width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                  child: Text('COMENTARIOS RELEVANTES', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 16.0,             
                  ),
                ),
              ),
              ],
              
            ),
            Divider( thickness: 1.0, color: Colors.lightGreen,),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height,
              child: _cargarListaComentarios(nombreProveedor),
            ),
          
          ],
        ),

      ),
    );
  }

    FutureBuilder<List<EvaluacionModelo>> _cargarListaComentarios(String nombreServicio) {
      
      return FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            return Container(
              child: Text("Carge Vacio "),  
            );
          }
          return new ListView.builder(

            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {
              EvaluacionModelo comentarios = projectSnap.data[index];
              //String dateFormate = DateFormat().format(DateTime.parse());
              
              return Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    
                    leading: _construirLeading(comentarios.puntuacion),                   
                    title: Text(" ${comentarios.usuario}  - ${comentarios.fecha}",  
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: 14.0,
                         
                      ),
                    ),
                    subtitle: Container(
                      padding: const EdgeInsets.all(4.0),
                     
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                         color: Colors.grey[100],
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container( 
                            alignment: Alignment.bottomLeft,                          
                          child: Text(comentarios.descripcion, 
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0,                           
                              ),
                            ),  
                        ),

                        //colocar fecha 
                        comentarios.fotoUrl != null ? Container(
                          alignment: Alignment.topLeft,
                        child: FadeInImage(
                          alignment: Alignment.topLeft,
                          
                          image: NetworkImage(comentarios.fotoUrl),
                          placeholder: AssetImage('assets/cargando.gif'),
                          height: 250.0,
                          width: 400.0,
                          fit:BoxFit.fitHeight ,

                        ),            
                      )
                      :Container(),
                        ]
                      ),
                    ),

                    
                    ),
                ],
              );
            },
          );
        },
        future: evaluacion.cargarComentarios(nombreServicio),
      );
    }

    Icon _construirLeading(double puntuacion){

      if(puntuacion == 5){
        return Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 60.30,);

      }else if(puntuacion == 4){
        return Icon(Icons.sentiment_satisfied, color: Colors.greenAccent, size: 60.30,);

      }else if(puntuacion == 3){
        return Icon(Icons.sentiment_neutral, color: Colors.yellow, size: 60.30,);

      }else if(puntuacion == 2){
        return Icon(Icons.sentiment_dissatisfied, color: Colors.orange, size: 60.30,);

      }else if(puntuacion == 1){
        return Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 60.30,);
      }

       return Icon(Icons.sentiment_neutral, color: Colors.grey, size: 60.30,);
    } 

  Card _construirGraficoTotales(List<EvaluacioneServicioSeries> data ) {
    return Card(
      elevation: 5,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5,top: 5),
                child: Text('RESULTADOS TOTALES', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14.0  
                ),),
              )
            ],
          ),
          Container(
            height: 300,
            width: 500,
            child: TotalesChart(data: data, afuera: true),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5,top: 5),

              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Cantidad de respuestas : ',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 14.0
                      ),
                      ),
                      Text('$totalEvaluaciones',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0
                      ),
                      )
                ],
              )
              ),
          ),
            SizedBox(height: 20,)
        ]
      ),
    );
  }

  Card _construirGraficoDistribucion(List<EvaluacioneServicioSeries> data) {
    return Card(
      elevation: 5,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5,top: 5),
                child: Text('RESULTADOS GENERALES', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14.0
                  
                ),),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 500,
                      child: TotalesChart(data: data, afuera: true),
                      
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Cantidad de respuestas : ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              fontSize: 14.0
                            ),
                            ),
                            Text('$totalEvaluaciones',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14.0
                            ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
              ],
               
            ),
          ),
           Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_very_satisfied, color:Colors.green, size: 90.0,),
                      SizedBox(height: 5,),
                      Text('$porcientoNivel5%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('$cantidadEnNivel5', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                    ],
                  ),
                ),
              ),
             Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_satisfied, color:Colors.greenAccent, size: 90.0,),
                      SizedBox(height: 5,),
                      Text('$porcientoNivel4%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('$cantidadEnNivel4', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_neutral, color:Colors.yellow, size: 90.0,),
                      SizedBox(height: 5,),
                      Text('$porcientoNivel3%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('$cantidadEnNivel3', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_dissatisfied, color:Colors.orange, size: 90.0,),
                      SizedBox(height: 5,),
                      Text('$porcientoNivel2%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('$cantidadEnNivel2', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_very_dissatisfied, color:Colors.red, size: 90.0,),
                      SizedBox(height: 5,),
                      Text('$porcientoNivel1%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('$cantidadEnNivel1', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                    ],
                  ),
                ),
              ),
                
            ],
          ),
        ],
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
                "Resultados de los servicios '${proveedor.servicio}' del Proveedor '${proveedor.nombre}' ",
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

    Future <List<EvaluacioneServicioSeries>> cargarDataParaTotalPorServicio(String nombreProveedor ) async {
    
    List<EvaluacionModelo> evaluaciones = await evaluacion.cargarEvaluaciones();
    totalEvaluaciones = 0;
    cantidadEnNivel1 = 0;
    cantidadEnNivel2 = 0;
    cantidadEnNivel3 = 0;
    cantidadEnNivel4 = 0;
    cantidadEnNivel5 = 0;
    porcientoNivel1 = 0;
    porcientoNivel2 = 0;
    porcientoNivel3 = 0;
    porcientoNivel4 = 0;
    porcientoNivel5 = 0;

    for (var i = 0; i < evaluaciones.length; i++) {
      if(evaluaciones[i].proveedor == nombreProveedor){

        if(evaluaciones[i].puntuacion == 1.0){
          cantidadEnNivel1 += 1;
        }else if(evaluaciones[i].puntuacion == 2.0){
          cantidadEnNivel2 += 1;
        }else if(evaluaciones[i].puntuacion == 3.0){
          cantidadEnNivel3 += 1;
        }else if(evaluaciones[i].puntuacion == 4.0){
          cantidadEnNivel4 += 1;
        }else if(evaluaciones[i].puntuacion == 5.0){
          cantidadEnNivel5 += 1;
        }
      }
    }
      List<EvaluacioneServicioSeries> data = [
      EvaluacioneServicioSeries(
        nivel:"1",
        cantidad: cantidadEnNivel1,
        barColor: charts.ColorUtil.fromDartColor(Colors.red[900]),
      ),
      EvaluacioneServicioSeries(
        nivel:"2",
        cantidad: cantidadEnNivel2,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange[400]),
      ),
      EvaluacioneServicioSeries(
        nivel:"3",
        cantidad: cantidadEnNivel3,
        barColor: charts.ColorUtil.fromDartColor(Colors.yellow[600]),
      ),
      EvaluacioneServicioSeries(
        nivel:"4",
        cantidad: cantidadEnNivel4,
        barColor: charts.ColorUtil.fromDartColor(Colors.green[400]),
      ),
      EvaluacioneServicioSeries(
        nivel:"5",
        cantidad: cantidadEnNivel5,
        barColor: charts.ColorUtil.fromDartColor(Colors.green[600]),
      ),
    ];
    totalEvaluaciones = cantidadEnNivel1 + cantidadEnNivel2 + cantidadEnNivel3 + cantidadEnNivel4 + cantidadEnNivel5;

    porcientoNivel1 = ((cantidadEnNivel1 / totalEvaluaciones )* 100).toInt();
    porcientoNivel2 = ((cantidadEnNivel2 / totalEvaluaciones )* 100).toInt();
    porcientoNivel3 = ((cantidadEnNivel3 / totalEvaluaciones )* 100).toInt();
    porcientoNivel4 = ((cantidadEnNivel4 / totalEvaluaciones )* 100).toInt();
    porcientoNivel5 = ((cantidadEnNivel5 / totalEvaluaciones )* 100).toInt();

    print(totalEvaluaciones);

    return data;
  }

}