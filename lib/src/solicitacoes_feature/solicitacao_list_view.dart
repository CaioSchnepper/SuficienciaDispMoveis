import 'package:flutter/material.dart';
import 'package:utfpr/src/services/solicitacoes.service.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_submit.view.dart';

import 'solicitacao_item.dart';
import 'solicitacao_details_view.dart';

class SolicitacaoListView extends StatefulWidget {
  const SolicitacaoListView({super.key});

  static const routeName = '/list';

  @override
  SolicitacaoListViewState createState() => SolicitacaoListViewState();
}

class SolicitacaoListViewState extends State<SolicitacaoListView> {
  List<Solicitacao> _solicitacoes = List.empty();

  @override
  void initState() {
    _getSolicitacoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitações públicas'),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        const SolicitacaoSubmitView(),
                  ),
                );
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'solicitacaoListView',
        itemCount: _solicitacoes.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _solicitacoes[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                item.title,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                "${item.date.day}/${item.date.month}/${item.date.year}",
                style: const TextStyle(fontSize: 16),
              ),
              leading: const Icon(Icons.check),
              tileColor: const Color.fromARGB(255, 213, 227, 255),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        SolicitacaoDetailsView(solicitacao: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _getSolicitacoes() async {
    final solicitacoes = await SolicitacoesService().fetch();
    setState(() {
      _solicitacoes = solicitacoes;
    });
  }
}
