// user_balance_widget.dart
import 'package:flutter/material.dart';
import 'package:skisubapp/shared/Ski_colors.dart';
import 'package:skisubapp/trans_signup.dart'; // Adjust the import path as needed

class UserBalanceWidget extends StatelessWidget {
  final SignupUser user;
  final double totalSettledAmount;
  final String currency;

  const UserBalanceWidget({
    Key? key,
    required this.user,
    required this.totalSettledAmount,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(16, 0, 199, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/splashimage.png'),
              ),
              Text(
                'Hello,\n${user.firstName}!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.notifications, color: Colors.white),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(23, 2, 81, 1),
                  Color.fromRGBO(23, 14, 128, 0.9),
                  Color.fromRGBO(23, 20, 155, 0.84),
                ],
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Main Balance',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${user.accountNumber} Balance: ${totalSettledAmount.toStringAsFixed(2)} $currency',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Icon(Icons.download, color: Colors.white),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Fund Wallet',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(side: const BorderSide(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
