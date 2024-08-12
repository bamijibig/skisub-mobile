import 'package:flutter/material.dart';
import 'package:skisubapp/carscreen.dart';
import 'package:skisubapp/homescreen.dart';
import 'package:skisubapp/hotelscreen.dart';
import 'package:skisubapp/services.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   int _selectedIndex = 0;

  // List of available screens
  final List<Widget> _screens = [
    Homescreen(),
    ServicesPage(),
    // WalletScreen(),
    // ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        
      //   // leading: Icon(Icons.notifications_none, color: Colors.black),
      // //   actions: [
      // //     Padding(
      // //       padding: const EdgeInsets.only(right: 16.0),
      // //       child: CircleAvatar(
      // //         backgroundImage: NetworkImage(
      // //             'https://via.placeholder.com/150'), // Replace with actual user image URL
      // //       ),
      // //     ),
      // //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance Display
            Container(
              height: 284,
              width:375,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(16,0,199,1),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Icon(Icons.circle, color: Colors.white,),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/splashimage.png'),
                      ),
                       Text(
                    'Hello,\nAbdullah!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 Spacer(),
                  Icon(Icons.notifications, color: Colors.white,)

                    ],
                    
                  ),
                 Spacer(),
                
                  Center(
                    child: Container(
                      height: 178,
                      width: 343,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient
                        ( colors: [
                            Color.fromRGBO(23, 2, 81, 1),
                            Color.fromRGBO(23, 14, 128, 0.9),
                            Color.fromRGBO(23, 20, 155, 0.84),
                ],)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 24, left: 24,top: 14,bottom: 14),
                        child: Column(
                          children: [
                            Text(
                              'Main Balance',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'NGN 2000.00',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Icon(Icons.download, color: Colors.white,),
                            SizedBox(height: 10),
                            // SizedBox(
                            //   height: 2,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Fund Wallet',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Quick Action
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuickActionItem(icon: Icons.house, label: 'Hotel Booking', 
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>HotelListScreen())), ),
                  
                  QuickActionItem(icon: Icons.car_rental, label: 'Car Booking',
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CarBookingPage())),
                  ),
                  // QuickActionItem(icon: Icons.tv, label: 'Cable TV'),
                  // QuickActionItem(icon: Icons.more_horiz, label: 'More'),
                ],
              ),
            ),
            // Recent Activity
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
            SizedBox(height: 20),
            Center(
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set to current active tab index
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Handle tap
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Services',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final onTap;

  QuickActionItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.blue[800]),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
        
      ),
    );
  }
}

class RecentActivityTile extends StatelessWidget {
  const RecentActivityTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.indigo,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // 15.hSpace,
          RichText(
            text: const TextSpan(
              text: 'Shopping ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text: '\n 15 March, 2024, 8:20PM',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          const Spacer(),
          const Text(
            '-NGN 150',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const
           Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}