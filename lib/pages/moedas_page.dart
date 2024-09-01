import 'package:cripto/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';

class MoedasPage extends StatelessWidget {
  const MoedasPage({super.key});

  @override
  Widget build(BuildContext context) {

  final tabela = MoedaRepository.tabela;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cripto Moedas'),
        centerTitle: true, // Centraliza o título
        backgroundColor: Colors.blue, // Define a cor azul para a AppBar
      ),
      body: ListView.separated(
      itemBuilder: (BuildContext context, int moeda) {
        return ListTile(
          leading: Image.asset(tabela[moeda].icone),
          title: Text(tabela[moeda].nome),
          trailing: Text(tabela[moeda].preco.toString()),
        );
      }, 
      padding: const EdgeInsets.all(16),
       separatorBuilder: (_,__) => const Divider(), 
       itemCount: tabela.length ,),
      );
  }
}
