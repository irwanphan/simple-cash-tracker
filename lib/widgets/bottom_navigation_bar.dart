import 'package:flutter/material.dart';

Widget buildBottomNavigationBar() {
  return BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Insights'),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
      BottomNavigationBarItem(icon: Icon(Icons.face), label: 'About'),
    ],
    fixedColor: Colors.blueGrey[900],
  );
}
