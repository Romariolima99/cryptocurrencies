import 'package:cripto/configs/app_setings.dart';
import 'package:cripto/models/moedas.dart';
import 'package:cripto/repositories/mocks_moedas.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GraficoHistorico extends StatefulWidget {
  final Moeda moeda;

  GraficoHistorico({super.key, required this.moeda});

  @override
  State<GraficoHistorico> createState() => _GraficoHistoricoState();
}

enum Periodo { hora, dia, semana, mes, ano, total }

class _GraficoHistoricoState extends State<GraficoHistorico> {
  List<Color> cores = [
    const Color(0xFF3F51B5),
  ];
  Periodo periodo = Periodo.hora;
  List<FlSpot> dadosGrafico = [];
  double maxX = 0;
  double maxY = 0;
  double minY = double.infinity;
  ValueNotifier<bool> loaded = ValueNotifier(false);
  late MoedaRepository repositorio;
  late Map<String, String> loc;
  late NumberFormat real;

  void setDados() {
    loaded.value = false;
    dadosGrafico.clear();

    // Obtenha o histórico da moeda
    List<Map<String, dynamic>> historico = repositorio.getHistoricoMoeda();

    // Verifique se a lista de histórico não é nula ou vazia
    if (historico.isNotEmpty) {
      // Pegue os dados correspondentes ao período selecionado
      List<dynamic> dadosCompletos = historico[periodo.index].values.first;

      // Reverter e mapear os dados
      dadosCompletos = dadosCompletos.reversed.map((item) {
        double preco = double.parse(item[0]);
        int time =
            int.parse('${item[1]}'); // Corrigido para não adicionar '000' aqui
        return [preco, DateTime.fromMillisecondsSinceEpoch(time)];
      }).toList();

      maxX = dadosCompletos.length.toDouble();
      for (var item in dadosCompletos) {
        maxY = item[0] > maxY ? item[0] : maxY;
        minY = item[0] < minY ? item[0] : minY;
      }

      for (int i = 0; i < dadosCompletos.length; i++) {
        dadosGrafico.add(FlSpot(i.toDouble(), dadosCompletos[i][0]));
      }

      loaded.value = true;
    } else {
      // Trate o caso em que não há dados disponíveis
      loaded.value = true;
      minY = 0;
      maxY = 1; // Defina valores padrão caso não haja dados
    }
  }

  LineChartData getChartData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: dadosGrafico,
          isCurved: true,
          color: const Color(0xFF3F51B5),
          barWidth: 2,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: cores.first.withOpacity(0.15),
          ),
        ),
      ],
    );
  }

  chartButton(Periodo p, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () => setState(() => periodo = p),
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            return (periodo != p) ? Colors.grey : Colors.black; // Cor do texto
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            return (periodo == p)
                ? (Colors.indigo[50] ??
                    Colors.indigo) // Valor padrão caso seja null
                : Colors.transparent; // Cor de fundo
          }),
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    repositorio = MoedaRepository();
    loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    setDados();

    return SingleChildScrollView(
      // Adicione o SingleChildScrollView aqui
      child: Container(
        height: 300, // Defina uma altura fixa ou limite
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AspectRatio(
              aspectRatio: 2,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        chartButton(Periodo.hora, '1H'),
                        chartButton(Periodo.dia, '24H'),
                        chartButton(Periodo.semana, '7D'),
                        chartButton(Periodo.mes, 'Mês'),
                        chartButton(Periodo.ano, 'Ano'),
                        chartButton(Periodo.total, 'Tudo'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: loaded,
                      builder: (context, isLoaded, _) {
                        return isLoaded
                            ? LineChart(getChartData())
                            : const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
