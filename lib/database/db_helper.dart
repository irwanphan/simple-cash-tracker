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
    if (_database != null) {
      // print('database found'); // DEBUG:
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions.db');

    // Tambahkan log untuk memastikan database ada atau tidak
    // print('Database path: $path'); // DEBUG:

    // Pastikan database lama dihapus hanya jika diperlukan
    final dbExists = await databaseExists(path);
    if (!dbExists) {
      // print('Database does not exist, creating a new one...'); // DEBUG:
    }

    // Buat database baru jika tidak ada
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            amount INTEGER NOT NULL,
            category TEXT NOT NULL,
            date TEXT NOT NULL
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
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('transactions');
      return maps.map((map) => Transaction.fromMap(map)).toList();
    } catch (e) {
      // print('Error fetching transactions: $e'); // DEBUG:
      return []; // Kembalikan daftar kosong jika terjadi error
    }
  }

  Future<int> countTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) as count FROM transactions');
    return Sqflite.firstIntValue(result) ?? 0; // Kembalikan jumlah record
  }

  // Hapus transaksi
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
