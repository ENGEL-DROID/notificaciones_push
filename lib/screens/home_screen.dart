import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
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
}
