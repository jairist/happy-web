import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }
  // GET y SET de la última página
  get userName {
    return _prefs.getString('userName') ?? 'admin';
  }

  set userName( String value ) {
    _prefs.setString('userName', value);
  }

    // GET y SET servicio seleccionado
  get userServicioSeleccionado {
    return _prefs.getString('userServicioSeleccionado') ?? 'Subsidio en Fripick';
  }

  set userServicioSeleccionado( String value ) {
    _prefs.setString('userServicioSeleccionado', value);
  }

}