// To parse this JSON data, do
//
//     final proveedorModelo = proveedorModeloFromJson(jsonString);

import 'dart:convert';

ProveedorModelo proveedorModeloFromJson(String str) => ProveedorModelo.fromJson(json.decode(str));

String proveedorModeloToJson(ProveedorModelo data) => json.encode(data.toJson());

class ProveedorModelo {
    String id;
    String nombre;
    String descripcion;
    String servicio;

    ProveedorModelo({
        this.id = "TEST01",
        this.nombre = "",
        this.descripcion = '',
        this.servicio = "",
    });

    factory ProveedorModelo.fromJson(Map<String, dynamic> json) => ProveedorModelo(
        id              : json["id"],
        nombre          : json["nombre"],
        descripcion     : json["Descripcion"],
        servicio        : json["servicio"],
    );

    Map<String, dynamic> toJson() => {
        "id"  :id,
        "nombre": nombre,
        "Descripcion": descripcion,
        "servicio"  :servicio,
    };
}
