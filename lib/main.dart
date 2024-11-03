import 'package:cripto/configs/app_setings.dart';
import 'package:cripto/meu_aplicativo.dart';
import 'package:cripto/repositories/conta_repository.dart';
import 'package:cripto/repositories/favoritas_repository.dart';
import 'package:cripto/repositories/mocks_moedas.dart';
import 'package:cripto/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Certifica que o Flutter está pronto antes de inicializar o Firebase

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCnGPP9RHdyjRclI7CdXWVg7g9AAVdNmbY",
      authDomain: "cripto-moedas-app-db93e.firebaseapp.com",
      projectId: "cripto-moedas-app-db93e",
      storageBucket: "cripto-moedas-app-db93e.appspot.com",
      messagingSenderId: "775825973558",
      appId: "1:775825973558:web:b0e900a0494d0513e95397",
      measurementId: "G-QWTCYY71PN",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        Provider(create: (context) => MoedaRepository()),
        ChangeNotifierProvider(
            create: (context) => ContaRepository(
                  moedas: context.read<MoedaRepository>(),
                )),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(
          create: (context) => FavoritasRepository(
            auth: context.read<AuthService>(),
            moedas: context.read<MoedaRepository>(),
          ),
        ),
      ],
      child: const MeuAplicativo(),
    ),
  );
}
