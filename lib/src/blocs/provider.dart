import 'package:flutter/material.dart';
import 'package:happy/src/blocs/agregar_proveedor.dart';
import 'package:happy/src/blocs/login_bloc.dart';
export 'package:happy/src/blocs/login_bloc.dart';

import 'package:happy/src/blocs/register_bloc.dart';
export 'package:happy/src/blocs/register_bloc.dart';

class Provider extends InheritedWidget{

  final loginBloc     = LoginBloc();
  final registerBloc  = RegisterBloc();
  final agregarProveedorBloc = AgregarProveedorBloc();
  
  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key : key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key : key, child: child);



  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
  
  static LoginBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static RegisterBloc registerBlocOf ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().registerBloc;
  }

   static AgregarProveedorBloc agregarProveedorBlocOf ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().agregarProveedorBloc;
  }

  


}