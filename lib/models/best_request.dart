class BestRequest {
  String tipo;
  int cantidad;

  BestRequest({
    this.tipo,
    this.cantidad,
  });

  Map<String, dynamic> toJson() => {
        'tipo': this.tipo,
        'cantidad': this.cantidad,
      };
}
