import 'package:flutter/material.dart';
import 'package:happy/src/models/evaluacion_model.dart';
import 'package:happy/src/models/proveedor.dart';
import 'package:happy/src/models/servicio_model.dart';
import 'package:happy/src/provider/api_services.dart';
import 'package:happy/src/provider/evaluacion_provider.dart';
import 'package:happy/src/provider/proveedores_provider.dart';
import 'package:happy/src/utils/utils.dart';
import 'package:happy/src/widgets/donut_chart.dart';
import 'package:happy/src/widgets/staket_barchar.dart';
import 'package:happy/src/widgets/table_card.dart';
import 'package:happy/src/widgets/tickets_cards.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AdminDashboardPage extends StatefulWidget {
  AdminDashboardPage({Key key}) : super(key: key);

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool loading = false;
  EvaluacionProvider evaluacion = new EvaluacionProvider();
  ProveedorProvider proveedorProvider = new ProveedorProvider();
  List<EvaluacionModelo> evaluaciones; 
  List<ProveedorModelo> proveedores;

  List<Servicio> servicios = Servicio.getServicios();

  int totalEvaluaciones = 0;
  int totalProveedores = 0;
  @override
  void initState() {
    super.initState();
    getDataFromUi();
    
  }
   getDataFromUi() async {
    loading = false;
    evaluaciones = await evaluacion.cargarEvaluaciones();
    proveedores = await proveedorProvider.cargarProveedores();
    totalEvaluaciones = evaluaciones.length;
    totalProveedores = proveedores.length;
    setState(() {
      loading = true;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
   
    

    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Column(
                  children: <Widget>[
                    MediaQuery.of(context).size.width < 1200
                        ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              tickets(colors[0], context, Icons.format_list_bulleted, totalProveedores, "Proveedores" ),
                              tickets(colors[1], context, Icons.sentiment_very_satisfied, servicios.length, "Servicios" ),
                              tickets(colors[2], context, Icons.spellcheck, totalEvaluaciones, "Evaluaciones" ),
                              tickets(colors[3], context, Icons.comment, totalEvaluaciones, "Comentarios" ),
                              
                            ],
                            ),
                        )
                        : Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              tickets(colors[0], context, Icons.format_list_bulleted, totalProveedores, "Proveedores" ),
                              tickets(colors[1], context, Icons.sentiment_very_satisfied, servicios.length, "Servicios" ),
                              tickets(colors[2], context, Icons.spellcheck, totalEvaluaciones, "Evaluaciones" ),
                              tickets(colors[3], context, Icons.comment, totalEvaluaciones, "Comentarios" ),    
                            ]),
                        ),
                    SizedBox(
                      height: 15,
                    ),
                    //colocar tabla aqui cuando este lista. 
                    SizedBox(
                    height: 16,
                  ),
                  loading
                      ? new TableCard().tableCard(
                          context,
                          //ApiData.githubTrendingModel,
                          //proveedorProvider.getData(),
                          proveedores,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),

                    Container(
                      child: Card(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 2,
                      margin:
                          EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                          child: StackedBarChart.withSampleData(),
                    ),
                    ),
                    )
                    
     
                  ],
                ),
              ),
            ]),
          ),
          // SliverGrid(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 3,
          //   childAspectRatio:
          //         MediaQuery.of(context).size.width < 100 ? 0.6 : 0.65,
          //     mainAxisSpacing: 10,
          //   ),
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Card(
          //         shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(5.0),
          //         ),
          //         elevation: 2,
          //         margin:
          //             EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          //         child: Container(
          //           width: 800,
          //           height: 800,
          //             child: StackedBarChart.withSampleData(),
          //       ),
          //       );
          //     },
          //     childCount: 1,
          //   ),
          // )
        ],
      ),
    );

    
  }

  /// Create one series with sample hard coded data.REMOVER LUEGO.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}