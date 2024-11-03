import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class DocumentosPage extends StatefulWidget {
  const DocumentosPage({super.key});

  @override
  State<DocumentosPage> createState() => _DocumentosPageState();
}

class _DocumentosPageState extends State<DocumentosPage> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  XFile? imagem;
  Size? size;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      print(e.toString()); // Correção do tratamento de exceções
    }
  }

  _startCamera() {
    if (cameras.isEmpty) {
      print('Câmera não foi encontrada');
      return; // Para garantir que o código abaixo não seja executado se não houver câmeras
    } else {
      _previewCamera(cameras.first);
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print(e.toString()); // Atualizado para o novo método de exceção
    }

    if (mounted) {
      setState(() {}); // Apenas uma chamada para atualizar o estado da tela
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context)
        .size; // Não está sendo usado, então pode ser removido se não for necessário

    return Scaffold(
      appBar: AppBar(
        title: const Text("Documentos Oficial"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: _arquivoWidget(),
        ),
      ),
      floatingActionButton: (imagem != null)
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pop(context),
              label: const Text('Finalizar'),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _arquivoWidget() {
    return Container(
      width: size!.width - 50,
      height: size!.height - (size!.height / 3),
      child: imagem == null
          ? _cameraPreviwWidget()
          : Image.file(File(imagem!.path), fit: BoxFit.contain),
    );
  }

  _cameraPreviwWidget() {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text('erro ao caregar Camera');
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CameraPreview(controller!),
          _botaoCapturaWidget(),
        ],
      );
    }
  }

  _botaoCapturaWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: IconButton(
          onPressed: tirarFoto,
          icon: const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  tirarFoto() async {
    final CameraController? cameraController = controller;
    if (cameraController != null && cameraController.value.isInitialized) {
      try {
        XFile file = await cameraController.takePicture();
        if (mounted) setState(() => file = file);
      } on CameraException catch (e) {
        print(e.description);
      }
    }
  }
}
