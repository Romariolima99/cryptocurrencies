import 'package:cripto/models/moedas.dart';
import 'package:cripto/pages/favoritas_page.dart';
import 'package:cripto/pages/moedas_detalhes_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedaCard extends StatefulWidget {
  final Moeda moeda; // Corrigido para final, já que não será alterado após a construção

   MoedaCard({Key? key, required this.moeda,}) : super(key: key); // Removida a duplicata do parâmetro moeda

  @override
  State<MoedaCard> createState() => _MoedaCardState();
}

class _MoedaCardState extends State<MoedaCard> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  static Map<String, Color> precoColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.indigo,
  };

  void abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: widget.moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => abrirDetalhes(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              Image.asset(
                widget.moeda.icone, // Corrigido de widget.moeda para widget.moedas
                height: 40,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12), // Corrigido de EdgeInsets.all
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.moeda.nome, // Corrigido de widget.moeda para widget.moedas
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.moeda.sigla, // Corrigido de widget.moeda para widget.moedas
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: precoColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: precoColor['down']!.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  real.format(widget.moeda.preco), // Corrigido de widget.moeda para widget.moedas
                  style: TextStyle(
                    fontSize: 16,
                    color: precoColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: const Text('Remover das favoritas'),
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<FavoritasPage>(context, listen: false);
                        // .remove(widget.moeda);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
