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
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(
                  context, SolicitacaoSubmitView.routeName);
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

          return ListTile(
            title: Text(item.title),
            leading: const Icon(Icons.pages),
            onTap: () {
              // Navigate to the details page. If the user leaves and returns to
              // the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(
                context,
                SolicitacaoDetailsView.routeName,
              );
            },
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
