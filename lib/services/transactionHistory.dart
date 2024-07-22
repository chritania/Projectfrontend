import 'package:flutter/material.dart';

class transactionHistory extends StatefulWidget {
  const transactionHistory({super.key});

  @override
  State<transactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<transactionHistory> {
  final List<Map<String, String>> transactions = [
    {"date": "2024-07-01", "description": "Groceries", "amount": "\$50.00"},
    {"date": "2024-07-02", "description": "Electricity Bill", "amount": "\$30.00"},
    {"date": "2024-07-03", "description": "Online Shopping", "amount": "\$120.00"},
    {"date": "2024-07-04", "description": "Dinner", "amount": "\$25.00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white70,
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green, // Top color
              Colors.yellow, // Middle color
              Colors.green, // Bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0], // Gradient stops for each color
          ),
        ),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.monetization_on, color: Colors.green),
                title: Text(transaction["description"]!),
                subtitle: Text(transaction["date"]!),
                trailing: Text(transaction["amount"]!),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: transactionHistory(),
  ));
}
