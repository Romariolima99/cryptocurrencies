import 'dart:convert';
import 'package:cripto/models/moedas.dart';
import 'package:cripto/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cripto/models/posicao.dart';

class ContaRepository extends ChangeNotifier {
  List<Posicao> _carteira = []; // Inicialização da carteira
  double _saldo = 0;

  double get saldo => _saldo;
  List<Posicao> get carteira => _carteira; // Getter para carteira

  ContaRepository() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    await _getSaldo();
    await _getCarteira();
  }

  Future<void> _getSaldo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _saldo = prefs.getDouble('saldo') ?? 0; // Valor padrão se não houver
    notifyListeners();
  }

  Future<void> setSaldo(double valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('saldo', valor);
    _saldo = valor;
    notifyListeners();
  }

  // Função de compra ajustada
  comprar(Moeda moeda, double valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Verificar se a moeda já foi comprada antes
    String? carteiraStr = prefs.getString('carteira');
    List<dynamic> carteira = carteiraStr != null ? jsonDecode(carteiraStr) : [];

    // Buscar a moeda pela sigla
    Map<String, dynamic>? posicaoMoeda;
    for (var posicao in carteira) {
      if (posicao['sigla'] == moeda.sigla) {
        posicaoMoeda = posicao;
        break;
      }
    }

    // Se a moeda não foi comprada antes, insere nova posição
    if (posicaoMoeda == null) {
      carteira.add({
        'sigla': moeda.sigla,
        'moeda': moeda.nome,
        'quantidade': (valor / moeda.preco).toString(),
      });
    } else {
      // Atualiza a quantidade da moeda existente
      double atual = double.parse(posicaoMoeda['quantidade']);
      posicaoMoeda['quantidade'] = (atual + (valor / moeda.preco)).toString();
    }

    // Atualizar a carteira no SharedPreferences
    await prefs.setString('carteira', jsonEncode(carteira));

    // Registrar no histórico
    String? historicoStr = prefs.getString('historico');
    List<dynamic> historico = historicoStr != null ? jsonDecode(historicoStr) : [];

    historico.add({
      'sigla': moeda.sigla,
      'moeda': moeda.nome,
      'quantidade': (valor / moeda.preco).toString(),
      'valor': valor,
      'tipo_operacao': 'compra',
      'data_operacao': DateTime.now().millisecondsSinceEpoch,
    });

    // Atualizar o histórico no SharedPreferences
    await prefs.setString('historico', jsonEncode(historico));

    // Atualizar o saldo
    double saldoAtual = prefs.getDouble('saldo') ?? 0;
    await prefs.setDouble('saldo', saldoAtual - valor);

    // Atualizar os dados da conta e carteira
    await _initRepository();
    notifyListeners();
  }

  // Carregar carteira do SharedPreferences
  _getCarteira() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _carteira = [];

    String? carteiraStr = prefs.getString('carteira');
    if (carteiraStr != null) {
      List<dynamic> posicoes = jsonDecode(carteiraStr);
      for (var posicao in posicoes) {
        Moeda moeda = MoedaRepository.tabela.firstWhere((m) => m.sigla == posicao['sigla']);
        _carteira.add(Posicao(
          moeda: moeda,
          quantidade: double.parse(posicao['quantidade']),
        ));
      }
    }
    notifyListeners();
  }
}
