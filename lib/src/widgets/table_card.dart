import 'package:flutter/material.dart';
import 'package:happy/src/models/evaluacion_model.dart';
import 'package:happy/src/models/global.dart';
import 'package:happy/src/models/proveedor.dart';


class TableCard{

Widget tablaProveedores(BuildContext context, List<ProveedorModelo> data) {
  //proveedores = proveedorProvider.cargarProveedores();
  int cantidad;

  if(!data.length.isNaN){
    cantidad = data.length;
  }else {
    cantidad = 0;
  }


  return Card(
    elevation: 5.0,
    child: Column(children: [
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        padding: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: lightGreen,
            border: Border(bottom: BorderSide(width: 1, color: Colors.greenAccent))),
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            0: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            1: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            2: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            3: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            4: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
          },
          children: [
            TableRow(decoration: BoxDecoration(), children: [
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "No.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "Proveedor",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "Descripción",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Servicio",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
               Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Accion",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        // padding: EdgeInsets.all(32),
        child: Table(
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              1: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              2: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              3: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              4: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            },
            children: List<TableRow>.generate(cantidad, (i) {
              return TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.6, color: Colors.grey))),
                  children: [
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].nombre.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].descripcion.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].servicio.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        'Ver Detalle',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    )
                  ]);
            })),
      ),
    ]),
  );
}


Widget tablaEvaluaciones(BuildContext context, List<EvaluacionModelo> data) {
  //proveedores = proveedorProvider.cargarProveedores();
   int cantidad;

  if(!data.length.isNaN){
    cantidad = data.length;
  }else {
    cantidad = 0;
  }
  return Card(
    elevation: 4.0,
    child: Column(children: [
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        padding: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: lightGreen,
            border: Border(bottom: BorderSide(width: 1, color: Colors.greenAccent))),
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            0: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            1: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            2: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            3: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            4: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
          },
          children: [
            TableRow(decoration: BoxDecoration(), children: [
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "No.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "Servicio",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "Evaluado por",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Puntuación ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
               Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Accion",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        // padding: EdgeInsets.all(32),
        child: Table(
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              1: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              2: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              3: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              4: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            },
            children: List<TableRow>.generate(cantidad, (i) {
              return TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.6, color: Colors.grey))),
                  children: [
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].servicio .toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].usuario .toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].puntuacion.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        'Ver Detalle',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    )
                  ]);
            })),
      ),
    ]),
  );
}


Widget tablaListaProveedores(BuildContext context, List<ProveedorModelo> data) {
  //proveedores = proveedorProvider.cargarProveedores();
   int cantidad;

  if(!data.length.isNaN){
    cantidad = data.length;
  }else {
    cantidad = 0;
  }

  return Card(
    elevation: 4.0,
    child: Column(children: [
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        padding: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: lightGreen,
            border: Border(bottom: BorderSide(width: 1, color: Colors.greenAccent))),
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            0: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            1: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            2: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            3: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            4: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
          },
          children: [
            TableRow(decoration: BoxDecoration(), children: [
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "No.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "Proveedor",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "Descripción",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Servicio",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
               Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Accion",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        // padding: EdgeInsets.all(32),
        child: Table(
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              1: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              2: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              3: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
              4: FixedColumnWidth((MediaQuery.of(context).size.width / 6)),
            },
            children: List<TableRow>.generate(cantidad, (i) {
              return TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.6, color: Colors.grey))),
                  children: [
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].nombre.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].descripcion.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        data[i].servicio.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: FlatButton(
                          color: Colors.lightGreen,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.greenAccent,
                          onPressed: () {
                            Navigator.pushNamed(context, 'detalleProveedor');
                          },
                          child: Text(
                            "Ver detalles",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      )
                    )
                  ]);
            })),
      ),
    ]),
  );
}

}