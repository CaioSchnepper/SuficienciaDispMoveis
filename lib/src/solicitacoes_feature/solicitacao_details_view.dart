import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:utfpr/src/services/auth.service.dart';
import 'package:utfpr/src/services/solicitacoes.service.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_item.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_list_view.dart';

class SolicitacaoDetailsView extends StatefulWidget {
  const SolicitacaoDetailsView({super.key, required this.solicitacao});

  static const routeName = '/details';

  final Solicitacao solicitacao;

  @override
  SolicitacaoDetailsViewState createState() => SolicitacaoDetailsViewState();
}

class SolicitacaoDetailsViewState extends State<SolicitacaoDetailsView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.solicitacao.title;
    _descriptionController.text = widget.solicitacao.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Column(
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
              widget.solicitacao.photo == ""
                  ? const SizedBox()
                  : SizedBox(
                      height: 250,
                      child:
                          Image.memory(base64Decode(widget.solicitacao.photo)),
                    ),
              const SizedBox(
                height: 30.0,
              ),
              Text("Latitude: ${widget.solicitacao.latitude}"),
              Text("Longitude: ${widget.solicitacao.longitude}"),
              const SizedBox(
                height: 30.0,
              ),
              (widget.solicitacao.user == AuthService().getCurrentUser())
                  ? TextButton(
                      onPressed: () => _delete(),
                      child: const Text('Excluir'),
                    )
                  : const SizedBox(),
              ElevatedButton(
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SolicitacaoListView(),
                    ),
                  ),
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _delete() async {
    String result = await SolicitacoesService().delete(widget.solicitacao);

    if (result == "Success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SolicitacaoListView(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao excluir"),
        ),
      );
    }
  }
}
