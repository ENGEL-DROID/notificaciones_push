import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  //
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
        ),
        actions: [
          IconButton(
            onPressed: () {
              final name = controller.text;

              createUser(name: name);

              controller.clear();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Home Screen'),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/message');
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                label: const Text('Message Screen'))
          ],
        ),
      ),
    );
  }

  Future createUser({required String name}) async {
    // reference to document
    final docUser =
        FirebaseFirestore.instance.collection('usuarios').doc('my-id');

    final json = {
      'name': name,
      'age': 20,
      'birthday': DateTime(2001, 7, 28),
    };

    print(name);

    // create document and write data to Firebase
    await docUser.set(json);
  }
}
