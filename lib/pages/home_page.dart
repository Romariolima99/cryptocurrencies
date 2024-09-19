import 'package:cripto/pages/Configuracoes_page.dart';
import 'package:cripto/pages/carteira_page.dart';
import 'package:cripto/pages/favoritas_page.dart';
import 'package:cripto/pages/moedas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int paginaAtual = 0;
late PageController pc;

@override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginAtual(pagina){
  setState(() {
    paginaAtual = pagina;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: PageView(
    controller: pc,
    children: [
      MoedasPage(),
      FavoritasPage(),
      CarteiraPage(),
      ConfiguracoesPage(),
     
    ],
    onPageChanged: setPaginAtual,
     ),
     bottomNavigationBar: BottomNavigationBar(
      currentIndex: paginaAtual,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'carteira'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
      ],
      onTap: (pagina){
      pc.animateToPage(pagina, duration: Duration(milliseconds:400), curve: Curves.ease);
      },
      backgroundColor: Colors.grey[100],
     ),
    );
  }
}