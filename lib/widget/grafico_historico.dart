import 'package:cripto/configs/app_setings.dart';
import 'package:cripto/models/moedas.dart';
import 'package:cripto/repositories/moeda_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GraficoHistorico extends StatefulWidget {
  Moeda moeda;

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
  List<Map<String, dynamic>> historico = [];
  List dadosCompletos = [];
  List<FlSpot> dadosGrafico = [];
  double maxX = 0;
  double maxY = 0;
  double minY = 0;
  ValueNotifier<bool> loaded = ValueNotifier(false);
  late MoedaRepository repositorio;
  late Map<String, String> loc;
  late NumberFormat real;

  setDados() async {
    loaded.value = false;
    dadosGrafico = [];

    if (historico.isEmpty) {
      historico = await repositorio.getHistoricoMoeda(widget.moeda);

      dadosCompletos = historico[periodo.index]['prices'];
      dadosCompletos = dadosCompletos.reversed.map((item) {
        double preco = double.parse(item[0]);
        int time = int.parse('${item[1]}000');
        return [preco, DateTime.fromMillisecondsSinceEpoch(time)];
      }).toList();

      maxX = dadosCompletos.length.toDouble();
      maxY = 0;
      minY = double.infinity;

      for (var item in dadosCompletos) {
        maxY = item[0] > maxY ? item[0] : maxY;
        minY = item[0] > minY ? item[0] : minY;
      }
      for (int i = 0; i < dadosCompletos.length; i++) {
        dadosGrafico.add(FlSpot(
          i.toDouble(),
          dadosCompletos[i][0],
        ));
      }
      loaded.value = true;
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
        maxY: maxX,
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
        ]);
  }

  @override
  Widget build(BuildContext context) {
    repositorio = context.read<MoedaRepository>();
    loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    setDados();
    return Container(
      child: AspectRatio(
        aspectRatio: 2,
        child: Stack(
          children: [
            ValueListenableBuilder(
                valueListenable: loaded,
                builder: (context, bool isLoaded, _) {
                  return (isLoaded)
                      ? LineChart(
                          getChartData(),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                })
          ],
        ),
      ),
    );
  }
}
