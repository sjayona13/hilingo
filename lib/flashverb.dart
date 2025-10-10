import 'package:flutter/material.dart';

class FlashVerb extends StatelessWidget {
  const FlashVerb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Greetings')),
      body: const Center(child: Text('This is the Greetings page')),
    );
  }
}
