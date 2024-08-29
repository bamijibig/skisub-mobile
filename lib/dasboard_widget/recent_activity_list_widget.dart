// recent_activity_list_widget.dart
import 'package:flutter/material.dart';
import 'package:skisubapp/trans_signup.dart';
// Adjust the import path as needed

class RecentActivityListWidget extends StatelessWidget {
  final List<Transaction> transactions;

  const RecentActivityListWidget({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: Column(
              children: const [
                Icon(
                  Icons.circle_outlined,
                  color: Colors.grey,
                  size: 50,
                ),
                SizedBox(height: 8),
                Text(
                  "Looks like there's no recent activity to show here.\nGet started by making a transaction",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : Column(
            children: transactions.map((transaction) => RecentActivityTile(transaction)).toList(),
          );
  }
}

class RecentActivityTile extends StatelessWidget {
  final Transaction transaction;

  const RecentActivityTile(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.tranRemarks,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                transaction.tranDateTime.toLocal().toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Text(
            '${transaction.currency} ${transaction.transactionAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
