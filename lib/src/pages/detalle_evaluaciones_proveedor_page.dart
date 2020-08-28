import 'package:flutter/material.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:happy/src/provider/proveedores_provider.dart';
import 'package:happy/src/utils/utils.dart';
import 'package:happy/src/widgets/donut_chart.dart';
import 'package:happy/src/widgets/table_card.dart';

class DetalleEvaluacionesProveedor extends StatelessWidget {

  final proveedorProvider = new ProveedorProvider();
  final _prefs = new PreferenciasUsuario();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: _construirDetalle(),
      ),
    );
  }

  Widget _construirDetalle(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
     //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: _construirGraficoTotales(),
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
          child: Container(
            color: Colors.green,
          ),
        )
      ],
    );
  }

  Card _construirGraficoTotales() {
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
            child: DonutPieChart.withSampleData(),
          ),
        ],
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




  Widget _crearListado() {
    return FutureBuilder(
      future: proveedorProvider.cargarProveedores(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<ProveedorModelo>> snapshot) {
        if(snapshot.hasData){
          final proveedores = snapshot.data;         
          return tablaProveedores(context, proveedores);
        }else {
          
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
    AppBar buildAppBar(BuildContext context) {
    return AppBar(

      automaticallyImplyLeading:
          MediaQuery.of(context).size.width < 1300 ? true : false,
           leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
      title:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 32),
              child: Text(
                "Happy! Admin Panel : ${_prefs.userName}  ",
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
}