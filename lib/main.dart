import 'package:cripto/configs/app_setings.dart';
import 'package:cripto/meu_aplicativo.dart';
import 'package:cripto/repositories/conta_repository.dart';
import 'package:cripto/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => ContaRepository()),
         ChangeNotifierProvider(create: (context) => AppSettings()),
         ChangeNotifierProvider(create: (context) => FavoritasRepository()),
     ],
     child: MeuAplicativo(),
    ),
  );
}
 