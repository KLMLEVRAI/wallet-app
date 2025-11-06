import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/wallet.dart';
import '../models/transaction.dart';
import '../utils/api_client.dart';

class WalletProvider with ChangeNotifier {
  Wallet? _wallet;
  double _balance = 0.0;
  List<Transaction> _transactions = [];
  bool _isLoading = false;

  Wallet? get wallet => _wallet;
  double get balance => _balance;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  Future<void> createWallet() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Generate a new wallet (simplified for demo)
      final wallet = Wallet(
        address: '0x${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}',
        privateKey: 'private_key_${DateTime.now().millisecondsSinceEpoch}',
        publicKey: 'public_key_${DateTime.now().millisecondsSinceEpoch}',
      );

      _wallet = wallet;
      _balance = 0.0;

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('wallet', jsonEncode(wallet.toJson()));

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> importWallet(String privateKey) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Import wallet from private key (simplified for demo)
      final wallet = Wallet(
        address: '0x${privateKey.hashCode.toRadixString(16)}',
        privateKey: privateKey,
        publicKey: 'public_key_${privateKey.hashCode}',
      );

      _wallet = wallet;
      await loadBalance();

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('wallet', jsonEncode(wallet.toJson()));

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loadBalance() async {
    if (_wallet == null) return;

    try {
      // Load balance from API or local storage
      final prefs = await SharedPreferences.getInstance();
      final savedBalance = prefs.getDouble('balance') ?? 0.0;
      _balance = savedBalance;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading balance: $e');
    }
  }

  Future<void> send(double amount, String recipientAddress) async {
    if (_wallet == null || _balance < amount) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate sending transaction
      await Future.delayed(const Duration(seconds: 2));

      _balance -= amount;

      // Add transaction to history
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.send,
        amount: amount,
        address: recipientAddress,
        timestamp: DateTime.now(),
        status: TransactionStatus.confirmed,
      );

      _transactions.insert(0, transaction);

      // Save balance and transactions
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('balance', _balance);
      await prefs.setString('transactions', jsonEncode(_transactions.map((t) => t.toJson()).toList()));

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addInfiniteMoney() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Add infinite money for demo purposes
      _balance += 1000000.0;

      // Add transaction to history
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.receive,
        amount: 1000000.0,
        address: _wallet?.address ?? 'Unknown',
        timestamp: DateTime.now(),
        status: TransactionStatus.confirmed,
      );

      _transactions.insert(0, transaction);

      // Save balance and transactions
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('balance', _balance);
      await prefs.setString('transactions', jsonEncode(_transactions.map((t) => t.toJson()).toList()));

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loadWallet() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final walletJson = prefs.getString('wallet');

      if (walletJson != null) {
        final walletMap = jsonDecode(walletJson);
        _wallet = Wallet.fromJson(walletMap);
        await loadBalance();
        await loadTransactions();
      }
    } catch (e) {
      debugPrint('Error loading wallet: $e');
    }
  }

  Future<void> loadTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final transactionsJson = prefs.getString('transactions');

      if (transactionsJson != null) {
        final transactionsList = jsonDecode(transactionsJson) as List;
        _transactions = transactionsList.map((t) => Transaction.fromJson(t)).toList();
      }
    } catch (e) {
      debugPrint('Error loading transactions: $e');
    }
  }

  void clearWallet() {
    _wallet = null;
    _balance = 0.0;
    _transactions = [];
    notifyListeners();
  }
}