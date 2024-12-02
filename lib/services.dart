// import 'package:flutter/material.dart';

// class ServicesPage extends StatefulWidget {
//   @override
//   _ServicesPageState createState() => _ServicesPageState();
// }

// class _ServicesPageState extends State<ServicesPage> {
//   int _selectedIndex = 1; // Default to Services tab

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     // Navigate to different screens based on index if needed
//     // For now, we'll just keep the tab highlight
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context); // Navigate back when back icon is pressed
//           },
//         ),
//         title: Text(
//           'Services',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2, // 2 columns
//           crossAxisSpacing: 16.0,
//           mainAxisSpacing: 16.0,
//           children: <Widget>[
//             // _buildServiceCard(Icons.phone, 'Airtime'),
//             // _buildServiceCard(Icons.wifi, 'Data'),
//             _buildServiceCard(Icons.hotel, 'Book Hotel'),
//             _buildServiceCard(Icons.directions_car, 'Car Rentals'),
//           ],
//         ),
//       ),
      
//     );
//   }

//   Widget _buildServiceCard(IconData icon, String title) {
//     return GestureDetector(
//       onTap: () {
//         // Handle navigation to respective service screen
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 40,
//               color: Colors.blue,
//             ),
//             SizedBox(height: 10),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:skisubapp/CarApp/carscreen.dart';
import 'package:skisubapp/HotelApp/hotelscreen.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int _selectedIndex = 1; // Default to Services tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens based on index if needed
    // For now, we'll just keep the tab highlight
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Navigator.pop(context); // Navigate back when back icon is pressed
        //   },
        // ),
        automaticallyImplyLeading: false,
        title: Text(
          'Services',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            _buildServiceCard(Icons.hotel, 'Book Hotel', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HotelListScreen()),
              );
            }),
            _buildServiceCard(Icons.directions_car, 'Car Rentals', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarBookingPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens for HotelScreen and CarScreen
class HotelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Hotel'),
      ),
      body: Center(
        child: Text('Welcome to the Hotel Booking Screen'),
      ),
    );
  }
}

class CarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Rentals'),
      ),
      body: Center(
        child: Text('Welcome to the Car Rental Screen'),
      ),
    );
  }
}
