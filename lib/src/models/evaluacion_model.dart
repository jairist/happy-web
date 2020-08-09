// To parse this JSON data, do
//
//     final evaluacionModelo = evaluacionModeloFromJson(jsonString);

import 'dart:convert';

EvaluacionModelo evaluacionModeloFromJson(String str) => EvaluacionModelo.fromJson(json.decode(str));

String evaluacionModeloToJson(EvaluacionModelo data) => json.encode(data.toJson());

class EvaluacionModelo {
    String id;
    String servicio;
    String usuario;
    double puntuacion;
    String descripcion;
    String fotoUrl;

    EvaluacionModelo({
        this.id,
        this.servicio = '',
        this.usuario = 'admin',
        this.puntuacion = 0.0,
        this.descripcion = '',
        this.fotoUrl,
    });

    factory EvaluacionModelo.fromJson(Map<String, dynamic> json) => EvaluacionModelo(
        id          : json["id"],
        servicio    : json["servicio"],
        usuario     : json["usuario"],
        puntuacion  : json["puntuacion"],
        descripcion : json["Descripcion"],
        fotoUrl     : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "servicio": servicio,
        "usuario": usuario,
        "puntuacion": puntuacion,
        "Descripcion": descripcion,
        "fotoUrl": fotoUrl,
    };
}
