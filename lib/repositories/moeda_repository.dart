import 'dart:async';
import 'dart:convert';
import 'package:cripto/models/moedas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'moeda.dart'; // Certifique-se de que a classe Moeda esteja importada corretamente

class MoedaRepository extends ChangeNotifier {
  List<Moeda> _tabela = [];
  late Timer intervalo;

  List<Moeda> get tabela => _tabela;

  MoedaRepository() {
    _fetchMoedas();
    _checkPrecos(); // Inicie a busca pelas moedas
  }

  Future<void> _checkPrecos() async {
    String uri = 'https://api.coinbase.com/v2/assets/prices?base=BRL';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> moedas = json['data'];

      for (var novo in moedas) {
        for (var atual in _tabela) {
          if (atual.baseId == novo['base_id']) {
            final preco = novo['prices']['latest_price'];
            final timestamp = DateTime.parse(preco['timestamp']);

            // Atualiza a moeda na tabela
            atual.preco = double.parse(novo['prices']['latest']);
            atual.timestamp = timestamp;
            atual.mudancaHora =
                double.parse(preco['percent_change']['hour'].toString());
            atual.mudancaDia =
                double.parse(preco['percent_change']['day'].toString());
            atual.mudancaSemana =
                double.parse(preco['percent_change']['week'].toString());
            atual.mudancaMes =
                double.parse(preco['percent_change']['month'].toString());
            atual.mudancaAno =
                double.parse(preco['percent_change']['year'].toString());
            atual.mudancaPeriodoTotal =
                double.parse(preco['percent_change']['all'].toString());
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> _fetchMoedas() async {
    String uri = 'https://api.coinbase.com/v2/assets/search';

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> moedas = json['data'] ?? [];

        _tabela = moedas.map<Moeda>((moeda) {
          return Moeda(
            baseId: moeda['id'] ?? '', // Valor padrão caso não exista
            icone: moeda['image_url'] ?? '', // Verifica se a chave existe
            sigla: moeda['symbol'] ?? '',
            nome: moeda['name'] ?? 'Nome não disponível',
            preco: _parseDouble(moeda['latest_price']?['amount']),
            timestamp: DateTime.now(), // Ajuste conforme necessário
            mudancaHora: _parseDouble(moeda['hour_change']),
            mudancaDia: _parseDouble(moeda['day_change']),
            mudancaSemana: _parseDouble(moeda['week_change']),
            mudancaMes: _parseDouble(moeda['month_change']),
            mudancaAno: _parseDouble(moeda['year_change']),
            mudancaPeriodoTotal: _parseDouble(moeda['all_time_change']),
          );
        }).toList();

        notifyListeners();
      } else {
        throw Exception(
            'Falha ao carregar moedas. Código: ${response.statusCode}');
      }
    } catch (e) {
      // Tratamento de erro genérico
      print('Erro ao buscar moedas: $e');
      throw Exception('Erro ao buscar moedas');
    }
  }

  double _parseDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '0.0') ?? 0.0;
  }
}
