import 'package:flutter/material.dart';

class SolicitacaoSubmitView extends StatelessWidget {
  const SolicitacaoSubmitView({super.key});

  static const routeName = '/submit';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();

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
              onPressed: takePicture(),
              child: const Text('Tirar foto'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: sendSolicitacao(),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  takePicture() {

  }

  sendSolicitacao() {
    // final message = await AuthService().login(
    //   email: _emailController.text,
    //   password: _passwordController.text,
    // );
    // if (message!.contains('Success')) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => const SolicitacaoListView(),
    //     ),
    //   );
    // }
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //   ),
    // );
  }

}
