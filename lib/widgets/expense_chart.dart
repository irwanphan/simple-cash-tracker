// lib/widgets/expense_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Sesuaikan jika menggunakan charts_flutter
import '../models/transaction.dart';

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
