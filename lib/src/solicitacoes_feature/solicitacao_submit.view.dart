import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utfpr/src/services/auth.service.dart';
import 'package:utfpr/src/services/solicitacoes.service.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_item.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_list_view.dart';
import 'package:uuid/uuid.dart';

class SolicitacaoSubmitView extends StatefulWidget {
  const SolicitacaoSubmitView({super.key});

  static const routeName = '/submit';

  @override
  SolicitacaoSubmitViewState createState() => SolicitacaoSubmitViewState();
}

class SolicitacaoSubmitViewState extends State<SolicitacaoSubmitView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova solicitação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Título'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _descriptionController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Descrição',
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () => takePicture(),
              child: const Text('Tirar foto'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () => sendSolicitacao(),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  void takePicture() {}

  Future<void> sendSolicitacao() async {
    if (await Permission.location.request().isGranted == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permissão necessária para o funcionamento do app."),
        ),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final solicitacao = Solicitacao(
        const Uuid().v4(),
        _titleController.text,
        _descriptionController.text,
        "photo",
        AuthService().getCurrentUser(),
        position.latitude,
        position.longitude,
        DateTime.now(),
        List.empty());

    final message = await SolicitacoesService().insert(solicitacao);
    if (message!.contains('Success')) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SolicitacaoListView(),
        ),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
