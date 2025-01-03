import 'package:flutter/material.dart';
import '../models/transaction.dart';

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
    final category = _selectedCategory;
    final date = DateTime.now();

    if (title.isNotEmpty && amount > 0) {
      final newTransaction = Transaction.create(
        title: title,
        amount: amount,
        category: category,
        date: date,
      );
      Navigator.pop(context, newTransaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul Transaksi'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Jumlah'),
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
              child: const Text('Simpan Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}
