import 'package:flutter/material.dart';
import 'package:utfpr/src/camera_feature/camera.view.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_item.dart';

class SolicitacaoDetailsView extends StatefulWidget {
  const SolicitacaoDetailsView({super.key, this.solicitacao});

  static const routeName = '/details';

  final Solicitacao? solicitacao;

  @override
  SolicitacaoDetailsViewState createState() => SolicitacaoDetailsViewState();
}

class SolicitacaoDetailsViewState extends State<SolicitacaoDetailsView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da solicitação'),
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
                minLines: 5,
                maxLines: 7,
                decoration: const InputDecoration(
                  hintText: 'Descrição',
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
