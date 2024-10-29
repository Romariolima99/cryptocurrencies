import 'package:cripto/configs/app_setings.dart';
import 'package:cripto/models/posicao.dart';
import 'package:cripto/repositories/conta_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarteiraPage extends StatefulWidget {
  const CarteiraPage({super.key});

  @override
  State<CarteiraPage> createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  int index = 0;
  double totalCarteira = 0;
  double saldo = 0;
  late NumberFormat real;
  late ContaRepository conta;

  String graficoLabel = '';
  double graficoValor = 0;
  List<Posicao> carteira = [];

  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    final loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    saldo = conta.saldo;

    setTotalCarteira();

    return Scaffold(
      // Removi o 'const' daqui
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Valor da Carteira',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Text(
              real.format(
                  totalCarteira), // Aqui, 'real' já pode ser usado sem o 'const'
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
              ),
            ),
            loadGrafico(),
            loadHistorico()
          ],
        ),
      ),
    );
  }

  setTotalCarteira() {
    final carteiraList = conta.carteira;
    setState(() {
      totalCarteira = conta.saldo;
      for (var posicao in carteiraList) {
        totalCarteira += posicao.moeda.preco * posicao.quantidade;
      }
    });
  }

  setGraficoDados(int index) {
    if (index < 0) return; // Adicione esta verificação

    if (index == carteira.length) {
      graficoLabel = 'saldo';
      graficoValor = conta.saldo;
    } else {
      graficoLabel = carteira[index].moeda.nome;
      graficoValor = carteira[index].moeda.preco * carteira[index].quantidade;
    }
  }

  loadCarteira() {
    carteira = conta.carteira; // Certifique-se de carregar a carteira aqui
    setGraficoDados(index);
    final tamanhoLista = carteira.length; // Remova o +1

    return List.generate(tamanhoLista + 1, (i) {
      // Adicione 1 aqui
      final isTouched = i == index;
      final isSaldo = i == tamanhoLista; // Verifique se é o saldo

      double porcentagem = 0;

      if (isSaldo) {
        porcentagem =
            conta.saldo / totalCarteira; // Aqui você não acessa carteira[i]
      } else {
        porcentagem =
            (carteira[i].moeda.preco * carteira[i].quantidade) / totalCarteira;
      }
      porcentagem *= 100;

      return PieChartSectionData(
        color: isTouched ? Colors.tealAccent : Colors.tealAccent[400],
        value: porcentagem,
        title: '${porcentagem.toStringAsFixed(0)}%',
        radius: 50.0,
        titleStyle: TextStyle(
          fontSize: isTouched ? 20.0 : 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    });
  }

  loadGrafico() {
    return (conta.saldo < 0)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(PieChartData(
                    sectionsSpace: 5,
                    centerSpaceRadius: 110,
                    sections: loadCarteira(),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event,
                          PieTouchResponse? pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse != null &&
                              pieTouchResponse.touchedSection != null) {
                            index = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          }
                        });
                      },
                    ))),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    real.format(graficoValor),
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  )
                ],
              )
            ],
          );
  }

  loadHistorico() {
    final historico = conta.historico;
    final date = DateFormat('dd/MM/yyy - hh:mm');
    List<Widget> widgets = [];
    for (var operacao in historico) {
      widgets.add(ListTile(
        title: Text(operacao.moeda.nome),
        subtitle: Text(date.format(operacao.dataOperacao)),
        trailing: Text(real.format(operacao.moeda.preco * operacao.quantidade)),
      ));
      widgets.add(const Divider());
    }
    return Column(
      children: widgets,
    );
  }
}
