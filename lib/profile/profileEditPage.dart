// import 'package:flutter/material.dart';

// class EditProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Your name',
//                 hintText: 'Johnson Jason',
//               ),
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Phone number',
//                 hintText: '08092213883',
//               ),
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 hintText: 'ebegbej@mail.com',
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Implement update logic
//                 },
//                 child: Text('Update'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class EditProfilePage extends StatefulWidget {
//   final String name;
//   final String phone;
//   final String email;

//   const EditProfilePage({
//     required this.name,
//     required this.phone,
//     required this.email,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   late TextEditingController nameController;
//   late TextEditingController phoneController;
//   late TextEditingController emailController;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with the passed data
//     nameController = TextEditingController(text: widget.name);
//     phoneController = TextEditingController(text: widget.phone);
//     emailController = TextEditingController(text: widget.email);
//   }

//   @override
//   void dispose() {
//     // Dispose controllers to free up resources
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Show Profile',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Your Name',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: nameController,
//               enabled: false, // Disable editing
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Phone Number',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: phoneController,
//               enabled: false, // Disable editing
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Email',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: emailController,
//               enabled: false, // Disable editing
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  const EditProfilePage({
    required this.name,
    required this.phone,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the passed data
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Show Profile', // Updated title
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                enabled: false, // Disable the field for editing
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Phone Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                enabled: false, // Disable the field for editing
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                enabled: false, // Disable the field for editing
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

