class Moeda {
  String baseId;
  String icone;
  String nome;
  String sigla;
  double preco;
  DateTime timestamp;
  double mudancaHora;
  double mudancaDia;
  double mudancaSemana;
  double mudancaMes;
  double mudancaAno;
  double mudancaPeriodoTotal;

  Moeda({
    required this.baseId,
    required this.icone,
    required this.nome,
    required this.sigla,
    required this.preco,
    required this.timestamp,
    required this.mudancaHora,
    required this.mudancaDia,
    required this.mudancaSemana,
    required this.mudancaMes,
    required this.mudancaAno,
    required this.mudancaPeriodoTotal,
  });

  // Método fromJson
  factory Moeda.fromJson(Map<String, dynamic> json) {
    return Moeda(
      baseId: json['base_id'],
      icone: json['icon'],
      nome: json['name'],
      sigla: json['symbol'],
      preco: json['price'].toDouble(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      mudancaHora: json['change_hour'].toDouble(),
      mudancaDia: json['change_day'].toDouble(),
      mudancaSemana: json['change_week'].toDouble(),
      mudancaMes: json['change_month'].toDouble(),
      mudancaAno: json['change_year'].toDouble(),
      mudancaPeriodoTotal: json['change_total'].toDouble(),
    );
  }

  // Método toJson
  Map<String, dynamic> toJson() {
    return {
      'base_id': baseId,
      'icon': icone,
      'name': nome,
      'symbol': sigla,
      'price': preco,
      'timestamp': timestamp,
      'change_hour': mudancaHora,
      'change_day': mudancaDia,
      'change_week': mudancaSemana,
      'change_month': mudancaMes,
      'change_year': mudancaAno,
      'change_total': mudancaPeriodoTotal,
    };
  }
}
