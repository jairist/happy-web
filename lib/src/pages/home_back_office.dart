import 'package:flutter/material.dart';
import 'package:happy/src/pages/detalle_evaluaciones_proveedor_page.dart';
import 'package:happy/src/pages/lista_proveedores_page.dart';
import 'package:happy/src/pages/regiter_page.dart';
import 'package:happy/src/pages/splash_page.dart';
import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';

import 'admin_dashboard_page.dart';
import 'agregar_proveedor_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int active = 0;
  final _prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 6, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
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
              Container(child: Icon(Icons.web)),
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
        ),
        body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                      margin: EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height,
                      width: 300,
                      color: Colors.white,
                      child: listDrawerItems(false)
                      ),
                ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                AdminDashboardPage(),
                AgregarProveedorPage(),
                ListaProveedores(),
                RegisterPage(),  
                DetalleEvaluacionesProveedor(),
                GraciasPage(),
                ],
                ),
              )
              ],
        ),
        drawer: Padding(
          padding: EdgeInsets.only(top: 56),
          child: Drawer(child: listDrawerItems(true))),
    );
  }

  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      children: <Widget>[
        createMenuOption(drawerStatus, 0, "Dashboard", Icon(Icons.dashboard)),
        createMenuOption(drawerStatus, 1, "Agregar proveedor", Icon(Icons.add_box)),
        createMenuOption(drawerStatus, 2, "Lista Proveedores", Icon(Icons.list)),
        createMenuOption(drawerStatus, 3, "Agregar Usuario", Icon(Icons.add)),
        createMenuOption(drawerStatus, 4, "Detalle", Icon(Icons.list)),
        createMenuOption(drawerStatus, 5, "Salir", Icon(Icons.exit_to_app))
      ]);
      
  }

  FlatButton createMenuOption(bool drawerStatus, int index, String nombreOpcion, Icon icon) {
    return FlatButton(
        color: tabController.index == index ? Colors.grey[100] : Colors.white,
        onPressed: () {
          print(tabController.index);
          tabController.animateTo(index);
          drawerStatus ? Navigator.pop(context) : print("");
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
            child: Row(children: [
              icon,
              SizedBox(
                width: 8,
              ),
              Text(
                nombreOpcion,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'HelveticaNeue',
                ),
              ),
            ]),
          ),
        ),
      );
  }
}