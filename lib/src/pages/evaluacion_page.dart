import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:happy/src/models/evaluacion_model.dart';
import 'package:happy/src/models/global.dart';
import 'package:happy/src/provider/evaluacion_provider.dart';
import 'package:happy/src/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
 
void main() => runApp(EvaluacionPage());
 
class EvaluacionPage extends StatefulWidget {
  @override
  _EvaluacionPageState createState() => _EvaluacionPageState();
}

class _EvaluacionPageState extends State<EvaluacionPage> {

  final _formKey = GlobalKey<FormState>();
  final  evaluacionProvider = new EvaluacionProvider();
  final sacaffoldKey = GlobalKey<ScaffoldState>();

  EvaluacionModelo evaluacion = new EvaluacionModelo();

  File foto;
  bool _guardando = false;
  

  @override
  Widget build(BuildContext context) {
    final String servicio = ModalRoute.of(context).settings.arguments;
    evaluacion.servicio = servicio;
    return Scaffold(
      key: sacaffoldKey,
      appBar: AppBar(
        // backgroundColor: Gradient(colors: [lightBlueIsh, lightGreen]),
        flexibleSpace: Container(
          decoration: BoxDecoration( gradient: LinearGradient(colors:  [lightBlueIsh, lightGreen])),
        ),
        automaticallyImplyLeading: true,
        title: Text('$servicio', style: TextStyle(color: Colors.white)),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), 
          onPressed: _seleccionarFoto
          ),
          IconButton(icon: Icon(Icons.camera_alt), 
          onPressed: _tomarFoto)
        ],
      ),
         body: SingleChildScrollView(
           child: Stack(
             children: <Widget>[
               Column(
                 children: <Widget>[
                   Stack(
                     children: <Widget>[
                   _crearFormularioEvaluacion(context, servicio),
                        // _crearFondo(servicio),
                     ],
                   ),
                   
                 ],
                 
               ),
               
             ],
             
           ),
         )
    );
  }

  Widget _crearFondo(String servicio) { 
    return HeaderPage(servicio: servicio);
  }

  Widget _crearFormularioEvaluacion(BuildContext context, String servicio) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
        children: <Widget>[
           _mostrarFoto(),
           _crearEstrellas(context, 3),
           _crearCampoDescripcion(servicio),
           _crearBoton(context)
           
              // Add TextFormFields and RaisedButton here.
        ]
        
      ),
    ),
    );
  }

  Widget _crearEstrellas(BuildContext context, int index ) {
    return RatingBar(
    initialRating: evaluacion.puntuacion,
    itemCount: 5,
    itemBuilder: (context, index) {
       switch (index) {
          case 0:
             return Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
             );
          case 1:
             return Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.redAccent,
             );
          case 2:
             return Icon(
                Icons.sentiment_neutral,
                color: Colors.amber,
             );
          case 3:
             return Icon(
                Icons.sentiment_satisfied,
                color: Colors.lightGreen,
             );
          case 4:
              return Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
              );
       }
    },
    onRatingUpdate: (rating) {
      evaluacion.puntuacion = rating;
     
      print(rating);
    },
    ); 
  }

  Widget _crearCampoDescripcion(String servicio) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        initialValue: evaluacion.descripcion,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Escriba un comentario',
          hintText: 'Compartanos algunos detalles sobre el servicio'
          
        ),

        onSaved: (value ) => evaluacion.descripcion = value,
        validator: (value) {
          if(value.length < 1){
            return 'Por favor ingrese una descripcion';
          }
          return null;
        },
        
        
      ),
    );
      
  }
   Widget _crearBoton(BuildContext context ) {
        return RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          // color: Colors.deepPurple,
          color: Colors.lightGreen,
          textColor: Colors.white,
          label: Text('Guardar'),
          icon: Icon(Icons.save_alt ),
          // textColor: Colors.white,
          onPressed: () async{
            
            if(!_formKey.currentState.validate()) return;
            setState(() {_guardando = true; });
          
            //ahora cambio el estado del formulario. 
            _formKey.currentState.save();

            if(foto != null){
              evaluacion.fotoUrl = await  evaluacionProvider.subirImagen(foto);
            }
            if (evaluacion.id == null){
              evaluacionProvider.crearEvaluacion(evaluacion);
            }else{
              evaluacionProvider.editarEvaluacion(evaluacion);

            }

            mostrarSnackbar('Registro guardado');



            Navigator.of(context).pushNamed('gracias');
          },
          
          );
      }

        void mostrarSnackbar(String mensaje){

        final snackbar = SnackBar(
          content: Text(mensaje),
          duration: Duration(milliseconds: 1500),
        );

        sacaffoldKey.currentState.showSnackBar(snackbar);
      }

       _mostrarFoto() {
 
    if (evaluacion.fotoUrl != null) {
 
      return Container();
 
    } else {
 
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }


  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);

  }

  _tomarFoto() async{
    _procesarImagen(ImageSource.camera);

  }

  _procesarImagen( ImageSource origen) async {
  foto = await ImagePicker.pickImage(
    source: origen
  );

  if(foto != null){
    evaluacion.fotoUrl = null;
  }
  setState(() {
    
  });

  }
}