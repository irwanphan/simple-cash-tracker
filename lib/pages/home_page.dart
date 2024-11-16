import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_list.dart';
import '../widgets/expense_chart.dart';
import 'add_transaction_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar transaksi
  final List<Transaction> _transactions = [
    Transaction('Makan Siang', 50000, 'Makanan'),
    Transaction('Transportasi', 20000, 'Transportasi'),
    Transaction('Belanja', 150000, 'Belanja'),
  ];

  // Fungsi untuk membuka halaman tambah transaksi
  Future<void> _navigateToAddTransactionPage() async {
    final newTransaction = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTransactionPage()),
    );

    // Jika transaksi baru ada, tambahkan ke daftar transaksi
    if (newTransaction != null && newTransaction is Transaction) {
      setState(() {
        _transactions.add(newTransaction);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Keuangan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddTransactionPage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: TransactionList(transactions: _transactions)),
          Container(
            height: 200,
            child: ExpenseChart(transactions: _transactions),
          ),
        ],
      ),
    );
  }
}
