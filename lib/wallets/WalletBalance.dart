
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting amounts with commas
import 'package:skisubapp/model/signup_user.dart';
import 'package:skisubapp/model/transaction.dart';
import 'package:skisubapp/services/transaction_service.dart';
import 'package:skisubapp/wallets/BankDetail.dart';


class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<Transaction> transactions = [];
  double totalSettledAmount = 0.0;
  final TransactionService _transactionService = TransactionService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    SignupUser? userDetails = await _transactionService.fetchUserDetails();
    List<Transaction> fetchedTransactions = [];

    if (userDetails != null) {
      List<dynamic> fetchedRecentActivities = 
          await _transactionService.fetchAllTransactions();

      // Filter to get only transactions
      fetchedTransactions = fetchedRecentActivities
          .where((item) => item is Transaction)
          .cast<Transaction>()
          .toList();

      double totalAmount = fetchedTransactions.fold(
          0.0, (sum, transaction) => sum + transaction.settledAmount);

      setState(() {
        transactions = fetchedTransactions;
        totalSettledAmount = totalAmount;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00', 'en_US'); // Formatter for amounts with commas

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Wallet',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Balance Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(16, 0, 199, 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Main Balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₦ ${numberFormat.format(totalSettledAmount)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Fund Wallet Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(16, 0, 199, 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                           context,
                            MaterialPageRoute(builder: (context) => BankDetailsPage()));
                      },
                      child: Text(
                        'Fund Wallet',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Recent Transactions Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('See all'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: transactions.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 64,
                                  color: Color.fromRGBO(16, 0, 199, 0.3),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Looks like there’s no recent transactions to show here. Get started by making a transaction",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return ListTile(
                                title: Text('Transaction - ${transaction.tranDateTime}'),
                                subtitle: Text('Status: ${transaction.channelId}'),
                                trailing: Text(
                                  '₦${numberFormat.format(transaction.settledAmount)}',
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
