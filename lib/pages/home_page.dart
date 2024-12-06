import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_list.dart';
import '../widgets/expense_chart.dart';
import 'add_transaction_page.dart';
import '../database/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar transaksi
  final DBHelper _dbHelper = DBHelper();
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions(); // Muat data dari database
  }

  Future<void> _loadTransactions() async {
    final transactions = await _dbHelper.fetchTransactions();
    print('Loaded transactions: ${transactions.length}'); // Debugging
    setState(() {
      _transactions = transactions;
    });
  }

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
        title: const Text('Cashflow'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddTransactionPage,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: ExpenseChart(transactions: _transactions),
          ),
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            double width =
                constraints.maxWidth > 640 ? 640 : constraints.maxWidth;
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width,
                child: TransactionList(transactions: _transactions),
              ),
            );
          })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTransactionPage,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
