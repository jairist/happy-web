class Servicio {
  int id;
  String name;
 
  Servicio(this.id, this.name);
 
  static List<Servicio> getServicios() {
    return <Servicio>[
      Servicio(2, 'Subsidio en Fripick'),
      Servicio(3, 'Creditos en Farmacias'),
      Servicio(4, 'Combustible'),
      Servicio(5, 'PedidosYa'),
      Servicio(6, 'Bonos de supermercados'),
      Servicio(7, 'Club de precio'),
    ];
  }
}