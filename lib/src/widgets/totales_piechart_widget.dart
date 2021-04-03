import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TotalesChart extends StatelessWidget {
  final List<EvaluacioneServicioSeries> data;
  final bool afuera;

  TotalesChart({@required this.data, @required this.afuera});

  @override
  Widget build(BuildContext context) {
     List<charts.Series<EvaluacioneServicioSeries, String>> series;
    if(afuera){
      series = [
      charts.Series(
        id: "Indices",
        data: data,
        domainFn: (EvaluacioneServicioSeries series, _) => series.nivel,
        measureFn: (EvaluacioneServicioSeries series, _) => series.cantidad,
        colorFn: (EvaluacioneServicioSeries series, _) => series.barColor,
        displayName: 'Cantidad de votos por Nivel',
        overlaySeries: true,
        //Personalizacion 
        labelAccessorFn: (EvaluacioneServicioSeries series, _) => 'Ni vel # ${series.nivel} catidad: ${series.cantidad}',
        
        )
  ];
    }else{
      series = [
      charts.Series(
        id: "Indices",
        data: data,
        domainFn: (EvaluacioneServicioSeries series, _) => series.nivel,
        measureFn: (EvaluacioneServicioSeries series, _) => series.cantidad,
        colorFn: (EvaluacioneServicioSeries series, _) => series.barColor,
        displayName: 'Cantidad de votos por Nivel',
        overlaySeries: false,
        //Personalizacion 
        labelAccessorFn: (EvaluacioneServicioSeries series, _) => '${series.nivel} : ${series.cantidad}',
        
        )

  ];
    }
    
  return new charts.PieChart(series,
        animate: true,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 60,
          arcRendererDecorators: [  // <-- add this to the code 
              charts.ArcLabelDecorator(
                showLeaderLines: true,
                labelPadding: 10,

              ) // <-- and this of course
            ]
          ),
        
        );
  }
  
}

class EvaluacioneServicioSeries {
  final String nivel;
  final double cantidad;
  final charts.Color barColor;

  EvaluacioneServicioSeries(
      {@required this.nivel,
      @required this.cantidad,
      @required this.barColor});
}