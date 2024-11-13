import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Keuangan Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

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

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Makanan';

  final List<String> _categories = [
    'Makanan',
    'Transportasi',
    'Belanja',
    'Lainnya'
  ];

  void _submitTransaction() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    final title = _titleController.text;
    final amount = int.tryParse(_amountController.text) ?? 0;
    // final category = _selectedCategory;

    if (title.isNotEmpty && amount > 0) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul Transaksi'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              items: _categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _submitTransaction,
              child: Text('Simpan Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String title;
  final int amount;
  final String category;

  Transaction(this.title, this.amount, this.category);
}

class ExpenseChart extends StatelessWidget {
  final List<Transaction> transactions;

  const ExpenseChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = _generateChartSections();

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 40,
        sectionsSpace: 2,
      ),
    );
  }

  List<PieChartSectionData> _generateChartSections() {
    Map<String, int> categoryTotals = {};
    for (var transaction in transactions) {
      if (categoryTotals.containsKey(transaction.category)) {
        categoryTotals[transaction.category] =
            categoryTotals[transaction.category]! + transaction.amount;
      } else {
        categoryTotals[transaction.category] = transaction.amount;
      }
    }

    return categoryTotals.entries.map((entry) {
      final color = Colors.primaries[
          categoryTotals.keys.toList().indexOf(entry.key) %
              Colors.primaries.length];
      return PieChartSectionData(
        color: color,
        value: entry.value.toDouble(),
        title: '${entry.key}: Rp${entry.value}',
        radius: 50,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      );
    }).toList();
  }
}

class ExpenseData {
  final String category;
  final int total;

  ExpenseData(this.category, this.total);
}
