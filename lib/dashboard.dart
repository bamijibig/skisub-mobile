import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skisubapp/CarApp/carscreen.dart';
import 'package:skisubapp/HotelApp/hotelscreen.dart';
import 'package:skisubapp/model/carorder.dart';
import 'package:skisubapp/model/hotelorder.dart';
import 'package:skisubapp/model/transaction.dart';
import 'package:skisubapp/services/transaction_service.dart';
import 'package:skisubapp/model/signup_user.dart';
import 'package:skisubapp/wallets/BankDetail.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  SignupUser? signupUser;
  List<Transaction> transactions = [];
  List<dynamic> recentActivities = [];
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
    List<dynamic> fetchedRecentActivities = [];

    if (userDetails != null) {
      fetchedRecentActivities = await _transactionService.fetchAllTransactions();

      // Filter and calculate only transaction amounts
      fetchedTransactions = fetchedRecentActivities
          .where((item) => item is Transaction)
          .cast<Transaction>()
          .toList();

      double totalAmount = fetchedTransactions.fold(
          0.0, (sum, transaction) => sum + transaction.settledAmount);

      setState(() {
        signupUser = userDetails;
        transactions = fetchedTransactions;
        recentActivities = fetchedRecentActivities;
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
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    SizedBox(height: 15),
                    _buildQuickActions(context),
                    SizedBox(height: 15),
                    _buildRecentActivity(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader() {
    final numberFormat = NumberFormat('#,##0.00', 'en_US');
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(16, 0, 199, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/splashimage.png'),
              ),
              Text(
                'Hello,\n ${signupUser?.firstName ?? "User"}',
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
                  Text(
                    '₦ ${numberFormat.format(totalSettledAmount)}',
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
                    onPressed: () {
                      Navigator.push(
                           context,
                            MaterialPageRoute(builder: (context) => BankDetailsPage()));
                    },
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
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          SizedBox(height: 15),
          Builder(
            builder: (context) {
              if (recentActivities.isEmpty) {
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
              }
              return Column(
                children: recentActivities.map((activity) {
                  if (activity is HotelOrder) {
                    return HotelOrderTile(hotelOrder: activity);
                  } else if (activity is CarOrder) {
                    return CarOrderTile(carOrder: activity);
                  } else {
                    return SizedBox.shrink();
                  }
                }).toList(),
              );
            },
          ),
        ],
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

class HotelOrderTile extends StatelessWidget {
  final HotelOrder hotelOrder;

  const HotelOrderTile({required this.hotelOrder});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00', 'en_US');
    return ListTile(
      title: Text('Hotel Booking - ${hotelOrder.booking.checkInDate}'),
      subtitle: Text('Status: ${hotelOrder.status}'),
      trailing: Text('₦${numberFormat.format(hotelOrder.booking.totalAmount)}'),
    );
  }
}

class CarOrderTile extends StatelessWidget {
  final CarOrder carOrder;

  const CarOrderTile({required this.carOrder});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00', 'en_US');
    return ListTile(
      title: Text('Car Booking - ${carOrder.booking.startDate}'),
      subtitle: Text('Status: ${carOrder.status}'),
      trailing: Text('₦${numberFormat.format(carOrder.booking.totalAmount)}'),
      
    );
  }
}
