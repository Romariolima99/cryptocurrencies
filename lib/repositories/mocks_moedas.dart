import 'dart:math';
import 'package:cripto/models/moedas.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'images/Bitcoin.png',
      nome: 'Bitcoin',
      sigla: 'BTC',
      preco: 1509.00,
      baseId: 'bitcoin',
      timestamp: DateTime.now(),
      mudancaHora: 0.5,
      mudancaDia: 2.0,
      mudancaSemana: 5.0,
      mudancaMes: 12.0,
      mudancaAno: 45.0,
      mudancaPeriodoTotal: 150.0,
    ),
    Moeda(
      icone: 'images/Ethereum.png',
      nome: 'Ethereum',
      sigla: 'ETH',
      preco: 1200.00,
      baseId: 'ethereum',
      timestamp: DateTime.now(),
      mudancaHora: -0.2,
      mudancaDia: 1.5,
      mudancaSemana: 4.2,
      mudancaMes: 10.8,
      mudancaAno: 38.5,
      mudancaPeriodoTotal: 120.0,
    ),
    Moeda(
      icone: 'images/Avalanche.png',
      nome: 'Avalanche',
      sigla: 'AVAX',
      preco: 0.99,
      baseId: 'AVAX',
      timestamp: DateTime.now(),
      mudancaHora: 0.1,
      mudancaDia: 0.9,
      mudancaSemana: 3.1,
      mudancaMes: 8.0,
      mudancaAno: 20.0,
      mudancaPeriodoTotal: 85.0,
    ),
    Moeda(
      icone: 'images/BNB.png',
      nome: 'BNB',
      sigla: 'BNB',
      preco: 2.50,
      baseId: 'BNB',
      timestamp: DateTime.now(),
      mudancaHora: -0.3,
      mudancaDia: 1.0,
      mudancaSemana: 2.8,
      mudancaMes: 6.5,
      mudancaAno: 15.0,
      mudancaPeriodoTotal: 60.0,
    ),
    Moeda(
      icone: 'images/Cardano.png',
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 30.00,
      baseId: 'Cardano',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/Chainlink.png',
      nome: 'Chainlink',
      sigla: 'LINK',
      preco: 30.00,
      baseId: 'Chainlink',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/Dogecoin.png',
      nome: 'Dogecoin',
      sigla: 'DOGE',
      preco: 30.00,
      baseId: 'Chainlink',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/LidowstETH.png',
      nome: 'Lido wstETH',
      sigla: 'WSTETH',
      preco: 30.00,
      baseId: 'WSTETH',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/Litecoin.png',
      nome: 'Dogecoin',
      sigla: 'Litecoin',
      preco: 30.00,
      baseId: 'Chainlink',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/SHIBAINU.png',
      nome: 'SHIBA INU',
      sigla: 'SHIB',
      preco: 30.00,
      baseId: 'SHIB',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/Solana.png',
      nome: 'Solana',
      sigla: 'SOL',
      preco: 30.00,
      baseId: 'SHIB',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/SUI.png',
      nome: 'SUI',
      sigla: 'SUI',
      preco: 30.00,
      baseId: 'SUI',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/Tether.png',
      nome: 'Tether',
      sigla: 'USDT',
      preco: 30.00,
      baseId: 'Tether',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/Toncoin.png',
      nome: 'Toncoin',
      sigla: 'TON',
      preco: 30.00,
      baseId: 'Toncoin',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/UNUS SED LEO.png',
      nome: 'UNUS SED LEO',
      sigla: 'LEO',
      preco: 30.00,
      baseId: 'UNUS SED LEO',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/USDS.jpeg',
      nome: 'USDS',
      sigla: 'USDS',
      preco: 30.00,
      baseId: 'USDS',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/WETH.png',
      nome: 'WETH',
      sigla: 'WETH',
      preco: 30.00,
      baseId: 'WETH',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/Wrapped Bitcoin.png',
      nome: 'Wrapped Bitcoin',
      sigla: 'WBTC',
      preco: 30.00,
      baseId: 'WBTC',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/WrappedTRON.png',
      nome: 'Wrapped TRON',
      sigla: 'WTRX',
      preco: 30.00,
      baseId: 'WTRX',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
    Moeda(
      icone: 'images/XRP.png',
      nome: 'XRP',
      sigla: 'XRP',
      preco: 30.00,
      baseId: 'WTRX',
      timestamp: DateTime.now(),
      mudancaHora: 0.2,
      mudancaDia: 1.2,
      mudancaSemana: 3.5,
      mudancaMes: 9.2,
      mudancaAno: 25.0,
      mudancaPeriodoTotal: 90.0,
    ),
  ];

  // Função para gerar dados mocados de histórico de preços
  List<Map<String, dynamic>> getHistoricoMoeda() {
    final Random rng = Random();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;

    return [
      {
        'hour': [
          for (var i = 0; i < 60; i++)
            [
              (rng.nextDouble() * 100).toStringAsFixed(2), // Preço aleatório
              (currentTime - (i * 60 * 1000))
                  .toString() // Timestamp de 1 hora atrás
            ]
        ],
      },
      {
        'day': [
          for (var i = 0; i < 24; i++)
            [
              (rng.nextDouble() * 100).toStringAsFixed(2), // Preço aleatório
              (currentTime - (i * 3600 * 1000))
                  .toString() // Timestamp de 1 dia atrás
            ]
        ],
      },
      {
        'week': [
          for (var i = 0; i < 7; i++)
            [
              (rng.nextDouble() * 100).toStringAsFixed(2), // Preço aleatório
              (currentTime - (i * 24 * 3600 * 1000))
                  .toString() // Timestamp de 1 semana atrás
            ]
        ],
      },
      {
        'month': [
          for (var i = 0; i < 30; i++)
            [
              (rng.nextDouble() * 100).toStringAsFixed(2), // Preço aleatório
              (currentTime - (i * 24 * 3600 * 1000))
                  .toString() // Timestamp de 1 mês atrás
            ]
        ],
      },
      {
        'year': [
          for (var i = 0; i < 12; i++)
            [
              (rng.nextDouble() * 100).toStringAsFixed(2), // Preço aleatório
              (currentTime - (i * 30 * 24 * 3600 * 1000))
                  .toString() // Timestamp de 1 ano atrás
            ]
        ],
      },
      {
        'total': [
          for (var i = 0; i < 100; i++)
            [
              (rng.nextDouble() * 100).toStringAsFixed(2), // Preço aleatório
              (currentTime - (i * 7 * 24 * 3600 * 1000))
                  .toString() // Timestamp de 100 semanas atrás
            ]
        ],
      }
    ];
  }
}
