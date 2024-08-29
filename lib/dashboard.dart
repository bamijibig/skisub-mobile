import 'package:flutter/material.dart';
import 'package:skisubapp/CarApp/carscreen.dart';
import 'package:skisubapp/HotelApp/hotelscreen.dart';
// import 'package:skisubapp/shared/Ski_colors.dart';
import 'package:skisubapp/trans_signup.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 
  // late SignupUser signupUser;
  // late List<Transaction> transactions;
  // late List<Transaction> userTransactions=[];
  // List<Transaction> userTransactions = filterTransactionsByAccount(transactions, signupUser.accountNumber);
  
  @override
  Widget build(BuildContext context) {
    // double totalSettledAmount = userTransactions.fold(0, (sum, transaction) => sum + transaction.settledAmount);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(16, 0, 199, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/splashimage.png'),
                        ),
                        Text(
                          'Hello,\n Abdullahi!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.notifications, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 30,
                      ),
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
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              'N20000',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Icon(Icons.download, color: Colors.white),
                            SizedBox(height: 10),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Fund Wallet',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                side: BorderSide(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Quick Action',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        QuickActionItem(
                          icon: Icons.house,
                          label: 'Hotel Booking',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelListScreen(),
                            ),
                          ),
                        ),
                        QuickActionItem(
                          icon: Icons.car_rental,
                          label: 'Car Booking',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarBookingPage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Activity',
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
              ),
              SizedBox(height: 15),
              Builder(
                builder: (context) {
                  bool isNotEmpty = true;
                  if (isNotEmpty) {
                    return Column(
                      children: List.generate(
                        10,
                        (index) => RecentActivityTile(),
                      ),
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}



class QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;

  QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(icon, color: Colors.blue[800]),
            ),
            SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class RecentActivityTile extends StatelessWidget {
  const RecentActivityTile({super.key});

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Wallet Funding - Bank Deposit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Text(
              '₦5000.00', // Replace with your amount
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.blue, // Color similar to the image
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date: July 14, 2024 | 14:25', // Replace with your date and time
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              'Completed', // Replace with the status of the transaction
              style: TextStyle(
                fontSize: 12,
                color: Colors.green, // Color similar to the image
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

} 