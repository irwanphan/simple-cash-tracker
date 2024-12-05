// lib/models/transaction.dart
class Transaction {
  final int id;
  final String title;
  final int amount;
  final String category;
  final DateTime date;

  // Konstruktor untuk membaca dari database
  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.category,
      required this.date});

  // Konstruktor untuk membuat transaksi baru tanpa ID
  Transaction.create({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  }) : id = 0; // Nilai ID default akan diabaikan oleh SQLite

  // Konversi ke Map untuk SQLite
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  // Konversi dari Map (database) ke objek Transaction
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'], // ID diambil dari database
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }
}
