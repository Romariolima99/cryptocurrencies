import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cripto/models/posicao.dart';

class ContaRepository extends ChangeNotifier {
  final List<Posicao> _carteira = []; // Inicialização da carteira
  double _saldo = 90;

  double get saldo => _saldo;
  List<Posicao> get carteira => _carteira; // Getter para carteira

  ContaRepository() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    await _getSaldo();
    await _loadCarteira(); // Carregar a carteira, se necessário
  }

  Future<void> _getSaldo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _saldo = prefs.getDouble('saldo') ?? 90; // Valor padrão se não houver
    notifyListeners();
  }

  Future<void> _loadCarteira() async {
    // Aqui você pode carregar a carteira de um arquivo ou outra fonte, se necessário
    // Por exemplo, pode usar SharedPreferences para armazenar a carteira como uma lista de strings ou JSON
  }

  Future<void> setSaldo(double valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('saldo', valor);
    _saldo = valor;
    notifyListeners();
  }
}
