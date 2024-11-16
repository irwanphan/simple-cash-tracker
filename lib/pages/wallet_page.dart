import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Center(
        child: const Text(
          'This is the Wallet Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
