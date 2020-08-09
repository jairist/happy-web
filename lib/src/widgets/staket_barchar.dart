/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedBarChart(this.seriesList, {this.animate});

  /// Creates a stacked [BarChart] with sample data and no transition.
  factory StackedBarChart.withSampleData() {
    return new StackedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      animationDuration: Duration(microseconds: 250),
      vertical: true,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final servicioComida = [
      new OrdinalSales('AlmuerzoCxD', 2),
      new OrdinalSales('AlmuerzoCxA', 5),
      new OrdinalSales('AlmuerzoCxB', 3),
      new OrdinalSales('AlmuerzoCxC', 4),
    ];

    final tableSalesData = [
      new OrdinalSales('AlmuerzoCxD', 3),
      new OrdinalSales('AlmuerzoCxA', 5),
      new OrdinalSales('AlmuerzoCxB', 1),
      new OrdinalSales('AlmuerzoCxC', 2),
    ];

    final mobileSalesData = [
      new OrdinalSales('AlmuerzoCxD', 2),
      new OrdinalSales('AlmuerzoCxA', 5),
      new OrdinalSales('AlmuerzoCxB', 4),
      new OrdinalSales('AlmuerzoCxC', 2),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Almuerzo',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: servicioComida,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
