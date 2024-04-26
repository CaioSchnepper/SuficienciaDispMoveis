import 'package:flutter/material.dart';

class SolicitacaoDetailsView extends StatelessWidget {
  const SolicitacaoDetailsView({super.key});

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da solicitação'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
