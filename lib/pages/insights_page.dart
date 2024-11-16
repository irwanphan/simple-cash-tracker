import 'package:flutter/material.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: Center(
        child: const Text(
          'This is the Insights Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
