// lib/widgets/transaction_list.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  transactions[index].title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(transactions[index].category),
                trailing: Text('Rp ${transactions[index].amount}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.green)),
              )),
        );
      },
    );
  }
}
