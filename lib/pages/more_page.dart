import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: Center(
        child: const Text(
          'This is the More Information Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
