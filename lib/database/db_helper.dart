import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import '../models/transaction.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() {
    return _instance;
  }

  // Inisialisasi database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT, -- Auto-increment ID
            title TEXT NOT NULL, -- Judul wajib diisi
            amount INTEGER NOT NULL, -- Jumlah wajib diisi
            category TEXT NOT NULL, -- Kategori wajib diisi
            date TEXT NOT NULL -- Tanggal wajib diisi
          )
        ''');
      },
    );
  }

  // Tambah transaksi ke database
  Future<int> insertTransaction(Transaction transaction) async {
    final db = await database;
    return await db.insert('transactions', transaction.toMap());
  }

  // Ambil semua transaksi
  Future<List<Transaction>> fetchTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    return List.generate(maps.length, (i) {
      return Transaction.fromMap(maps[i]);
    });
  }

  // Hapus transaksi
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
