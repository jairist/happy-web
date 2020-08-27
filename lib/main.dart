
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:happy/src/blocs/provider.dart';
import 'package:happy/src/pages/detalle_evaluaciones_proveedor_page.dart';
import 'package:happy/src/pages/evaluacion_page.dart';
// import 'package:happy/src/pages/gracias_page.dart';
import 'package:happy/src/pages/home_alternativo.dart';
import 'package:happy/src/pages/home_back_office.dart';
import 'package:happy/src/pages/lista_proveedores_page.dart';
// import 'package:happy/src/pages/home_page.dart';
import 'package:happy/src/pages/login_page.dart';
import 'package:happy/src/pages/regiter_page.dart';
import 'package:happy/src/pages/resetear_clave.dart';
import 'package:happy/src/pages/splash_page.dart';
import 'package:happy/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'src/models/global.dart';

  Future<void> main() async { 

    WidgetsFlutterBinding.ensureInitialized();
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    runApp(MyApp());
  }
 
class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    
    // SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
    //   statusBarColor: Colors.transparent
    // )); 
    
    if (kIsWeb) {
    // running on the web!
      return buildProviderWeb();
      } else {
    // NOT running on the web! You can check for additional platforms here.
      return buildProviderApp();
      }
    
  }

  Provider buildProviderWeb() {
    return Provider(
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Happy!',
    initialRoute: 'login',
    routes: {
      // 'basico' : (BuildContext context) => BasicoPage(), 
      'login'     : (BuildContext context) => LoginPage(), 
      'registro'  : (BuildContext context) => RegisterPage(), 
      //'home'      : (BuildContext context) => HomeAlternativo(), 
      'home'      : (BuildContext context) => HomeScreen(),
      'listaProveedores'  :  (BuildContext context) => ListaProveedores(),
      'detalleProveedor'  :  (BuildContext context) => DetalleEvaluacionesProveedor(),
      'evaluar'   : (BuildContext context) => EvaluacionPage(), 
      'resetear'   : (BuildContext context) => ResetearClave(), 
      'gracias'   : (BuildContext context) => GraciasPage(), 
    },
    theme: ThemeData(
      primaryColor: lightGreen,
      
    ),
  ),
  );
  }

  Provider buildProviderApp() {
    return Provider(
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Happy!',
    initialRoute: 'login',
    routes: {
      // 'basico' : (BuildContext context) => BasicoPage(), 
      'login'     : (BuildContext context) => LoginPage(), 
      //'registro'  : (BuildContext context) => RegisterPage(), 
      'home'      : (BuildContext context) => HomeAlternativo(), 
      //'home'      : (BuildContext context) => HomeScreen(),  
      'evaluar'   : (BuildContext context) => EvaluacionPage(), 
      'gracias'   : (BuildContext context) => GraciasPage(), 
    },
    theme: ThemeData(
      primaryColor: lightGreen,
      fontFamily: 'HelveticaNeue',
      
    ),
  ),
  );
  }

}