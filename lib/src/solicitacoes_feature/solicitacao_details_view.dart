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
                  minLines: 2,
                  maxLines: 5,
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
                      height: 200,
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
              Column(
                children: <Widget>[
                  for (var item in widget.solicitacao.comments)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      child: ListTile(
                        title: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                ],
              ),
              TextButton(
                onPressed: () => _addComment(),
                child: const Text('Adicionar comentário'),
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

  void _addComment() {
    final TextEditingController commentController = TextEditingController();

    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Adição de comentário"),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(hintText: 'Descrição'),
        ),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          ElevatedButton(
              onPressed: () => {
                    _pushComment(commentController.text),
                    Navigator.pop(context, commentController.text)
                  },
              child: const Text('Confirmar')),
        ],
      ),
    );
  }

  _pushComment(String value) {
    widget.solicitacao.comments.add(value);
    SolicitacoesService().update(widget.solicitacao);
  }
}
