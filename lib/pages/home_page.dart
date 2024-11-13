// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_list.dart';
import '../widgets/expense_chart.dart';
import 'add_transaction_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Transaction> transactions = [
    Transaction('Makan Siang', 50000, 'Makanan'),
    Transaction('Transportasi', 20000, 'Transportasi'),
    Transaction('Belanja', 150000, 'Belanja'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan Keuangan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransactionPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: TransactionList(transactions: transactions)),
          Container(
            height: 200,
            child: ExpenseChart(transactions: transactions),
          ),
        ],
      ),
    );
  }
}
