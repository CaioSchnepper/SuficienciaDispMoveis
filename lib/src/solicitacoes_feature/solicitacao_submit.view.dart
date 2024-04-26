import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utfpr/src/camera_feature/camera.view.dart';
import 'package:utfpr/src/services/auth.service.dart';
import 'package:utfpr/src/services/solicitacoes.service.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_item.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_list_view.dart';
import 'package:uuid/uuid.dart';

class SolicitacaoSubmitView extends StatefulWidget {
  const SolicitacaoSubmitView({super.key, this.photo});

  static const routeName = '/submit';

  final String? photo;

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
      body: ListView(
        children: [
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
              widget.photo == null
                  ? TextButton(
                      onPressed: () => takePicture(),
                      child: const Text('Tirar foto'),
                    )
                  : SizedBox(
                      height: 250,
                      child: Image.file(
                        File(widget.photo!),
                      ),
                    ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () => sendSolicitacao(),
                child: const Text('Cadastrar'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextButton(
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

  Future<void> takePicture() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: firstCamera),
      ),
    );
  }

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
        widget.photo ?? "",
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
