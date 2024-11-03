import 'package:cripto/configs/app_setings.dart';
import 'package:cripto/pages/documentos_page.dart';
import 'package:cripto/repositories/conta_repository.dart';
import 'package:cripto/services/auth_service.dart';
// import 'package:cripto/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    final conta = context.watch<ContaRepository>();
    final loc = context.read<AppSettings>().locale;
    NumberFormat real =
        NumberFormat.currency(locale: loc['locale'], name: loc['name']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: const Text('Saldo'),
              subtitle: Text(
                real.format(conta.saldo),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                ),
              ),
              trailing: IconButton(
                onPressed: () => updateSaldo(),
                icon: const Icon(Icons.edit),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Escanear a CNH ou RG'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DocumentosPage(),
                  fullscreenDialog: true, // Corrigido aqui
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: OutlinedButton(
                    onPressed: () => context.read<AuthService>().logout(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors
                          .red, // Substitui o 'primary' por 'foregroundColor'
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Sair do App",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateSaldo() async {
    final form = GlobalKey<FormState>();
    final valor = TextEditingController();

    // Obtendo a conta do Provider
    final conta = context.read<ContaRepository>();
    valor.text = conta.saldo.toString();

    AlertDialog dialog = AlertDialog(
      title: const Text('Atualizar o saldo'),
      content: Form(
        key: form,
        child: TextFormField(
          controller: valor,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          validator: (value) {
            if (value!.isEmpty) return 'Informe o valor do saldo';
            if (double.tryParse(value) == null) return 'Valor inválido';
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (form.currentState!.validate()) {
              conta.setSaldo(double.parse(valor.text));
              Navigator.pop(context);
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
