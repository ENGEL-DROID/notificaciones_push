import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // variable para recibir la data de la notificación push:
    final args = ModalRoute.of(context)?.settings.arguments ?? 'No data';
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Screen'),
      ),
      body: Center(
        child: Text('Datos recividos: $args'),
      ),
    );
  }
}
