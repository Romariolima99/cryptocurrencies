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
    _fetchMoedas(); // Inicie a busca pelas moedas
  }

  Future<void> _fetchMoedas() async {
    String uri = 'https://api.coinbase.com/v2/assets/search?base=BRL';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> moedas = json['data'];

      _tabela = moedas.map<Moeda>((moeda) {
        // Certifique-se de que os campos correspondem ao que a API retorna
        return Moeda(
          baseId: moeda['id'], // Altere conforme necessário
          icone: moeda['image_url'], // Verifique se a chave existe
          sigla: moeda['symbol'],
          nome: moeda['name'],
          preco:
              double.tryParse(moeda['latest_price']?.toString() ?? '0') ?? 0.0,
          timestamp: DateTime.now(), // Use um timestamp adequado se disponível
          mudancaHora: 0.0, // Ajuste conforme necessário
          mudancaDia: 0.0, // Ajuste conforme necessário
          mudancaSemana: 0.0, // Ajuste conforme necessário
          mudancaMes: 0.0, // Ajuste conforme necessário
          mudancaAno: 0.0, // Ajuste conforme necessário
          mudancaPeriodoTotal: 0.0, // Ajuste conforme necessário
        );
      }).toList();

      notifyListeners(); // Notifica os ouvintes sobre a atualização
    } else {
      throw Exception('Falha ao carregar moedas');
    }
  }
}
