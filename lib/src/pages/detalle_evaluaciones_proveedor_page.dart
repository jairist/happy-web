import 'package:flutter/material.dart';
import 'package:happy/src/models/evaluacion_model.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:happy/src/provider/evaluacion_provider.dart';
import 'package:happy/src/provider/proveedores_provider.dart';
import 'package:happy/src/widgets/donut_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:happy/src/widgets/totales_piechart_widget.dart';

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
  int totalEvaluaciones = 0;
  //String servicio = 'Fripick'; 

//   void cargarData() async {
//   loading = false;
//   data = await cargarDataParaTotalPorServicio(servicio);
//   setState(() {
//     loading = true;
//   });
// }

  @override
  Widget build(BuildContext context) {
    final ProveedorModelo proveedor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: buildAppBar(context, proveedor),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: _construirDetalle(context, proveedor),
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
            Expanded(
              child: FutureBuilder <List<EvaluacioneServicioSeries>>(
                future: cargarDataParaTotalPorServicio(proveedor.servicio),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                     return Container(
                        child:_construirGraficoTotales(snapshot.data)
                      );
                  }else {
                    return  Center(child: CircularProgressIndicator(),);
                  }
                }
              ),
            ),
            Expanded(
              child: Container(
                child: _construirGraficoDistribucion(),
              ),
            ),
          ],  
        ),
        Expanded(
          child: Placeholder(),
          ),
      ],
    );
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
            child: TotalesChart(data: data),
          ),
          Container(
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
            SizedBox(height: 20,)
        ]
      ),
    );
  }

  Card _construirGraficoDistribucion() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  height: 300,
                  width: 500,
                  child: DonutPieChart.withSampleData(),
                  
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
                      Text('60%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('859', style: TextStyle(
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
                      Text('25%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('358', style: TextStyle(
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
                      Text('8%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('115', style: TextStyle(
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
                      Text('6%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('100', style: TextStyle(
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
                      Text('1%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 30.0
                      ),),
                      SizedBox(height: 5,),
                      Text('10', style: TextStyle(
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
            tooltip: 'Previous choice',
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
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.web),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'home');
                },
              ),          
            ),
            SizedBox(width: 32),
            Container(child: Icon(Icons.account_circle)),
            SizedBox(width: 32),
            Container(
              child: IconButton(
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

    Future <List<EvaluacioneServicioSeries>> cargarDataParaTotalPorServicio(String servicio ) async {
    
    List<EvaluacionModelo> evaluaciones = await evaluacion.cargarEvaluaciones();

    int cantidadEnNivel1 = 0;
    int cantidadEnNivel2 = 0;
    int cantidadEnNivel3 = 0;
    int cantidadEnNivel4 = 0;
    int cantidadEnNivel5 = 0;

    for (var i = 0; i < evaluaciones.length; i++) {
      if(evaluaciones[i].servicio == servicio){

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
    print(totalEvaluaciones);

    return data;
  }

}