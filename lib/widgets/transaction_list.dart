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
        return ListTile(
          title: Text(transactions[index].title),
          subtitle: Text(transactions[index].category),
          trailing: Text('Rp ${transactions[index].amount}'),
        );
      },
    );
  }
}
