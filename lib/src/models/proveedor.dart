// To parse this JSON data, do
//
//     final proveedorModelo = proveedorModeloFromJson(jsonString);

import 'dart:convert';

ProveedorModelo proveedorModeloFromJson(String str) => ProveedorModelo.fromJson(json.decode(str));

String proveedorModeloToJson(ProveedorModelo data) => json.encode(data.toJson());

class ProveedorModelo {
    String id;
    String id_fb;
    String nombre;
    String descripcion;
    String servicio;

    ProveedorModelo({
        this.id = "TEST01",
        this.id_fb = "TEST01",
        this.nombre = "",
        this.descripcion = '',
        this.servicio = "",
    });

    factory ProveedorModelo.fromJson(Map<String, dynamic> json) => ProveedorModelo(
        id              : json["id"],
        id_fb           : json["id_fb"],
        nombre          : json["nombre"],
        descripcion     : json["Descripcion"],
        servicio        : json["servicio"],
    );

    Map<String, dynamic> toJson() => {
        "id"  :id,
        "id_fb"  :id_fb,
        "nombre": nombre,
        "Descripcion": descripcion,
        "servicio"  :servicio,
    };
}
