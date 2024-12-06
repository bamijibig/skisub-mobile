// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         // leading: IconButton(
//         //   icon: Icon(Icons.arrow_back),
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   },
//         // ),
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('assets/images/png/profile_image.png'), // Replace with your image
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Johnson Jason',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'ebegbej@mail.com',
//               style: TextStyle(color: Colors.grey),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement photo upload
//               },
//               child: Text('Upload Photo'),
//             ),
//             SizedBox(height: 20),
            
//             // Converted ListTile to Container for Personal Information
//             GestureDetector(
//               onTap: () {
//                 // Navigate to personal information page
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//                 decoration: BoxDecoration(
//                   // color: Colors.white,
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey[300]!),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.person, color: Colors.black),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Text(
//                         'Personal Information',
//                         style: TextStyle(fontSize: 16.0, color: Colors.black),
//                       ),
//                     ),
//                     Icon(Icons.arrow_forward_ios, color: Colors.black),
//                   ],
//                 ),
//               ),
//             ),
            
//             // Converted ListTile to Container for Settings
//             GestureDetector(
//               onTap: () {
//                 // Navigate to settings page
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey[300]!),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.settings, color: Colors.black),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Text(
//                         'Settings',
//                         style: TextStyle(fontSize: 16.0, color: Colors.black),
//                       ),
//                     ),
//                     Icon(Icons.arrow_forward_ios, color: Colors.black),
//                   ],
//                 ),
//               ),
//             ),
            
//             // Add more custom containers as needed
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';
// import 'dart:io';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jpowered.pythonanywhere.com/account/'));
//   String? photoUrl;
//   String? name;
//   String? email;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProfileData();
//   }

//   Future<void> fetchProfileData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');
//       final userId = prefs.getInt('user_id');

//       if (token == null || userId == null) {
//         throw Exception('Missing authentication token or user ID');
//       }

//       final response = await _dio.get(
//         'userdetail/',
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Token $token',
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         setState(() {
//           name = '${data['first_name']} ${data['last_name']}';
//           email = data['email'];
//           photoUrl = data['photo_url'];
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load profile data');
//       }
//     } catch (e) {
//       print('Error fetching user details: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> uploadProfilePhoto() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');
//       final userId = prefs.getInt('user_id') ?? 0;

//       if (token == null) {
//         throw Exception('Missing authentication token');
//       }

//       final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//       if (pickedFile == null) return;

//       File photo = File(pickedFile.path);
//       FormData formData = FormData.fromMap({
//         "user": userId,
//         'profile_photo': await MultipartFile.fromFile(photo.path, filename: 'photo.jpg'),
//       });

//       final response = await _dio.patch(
//         'userdetail/',
//         data: formData,
//         options: Options(headers: {
//           'Authorization': 'Token $token',
//         }),
//       );

//       if (response.statusCode == 200) {
//         print('Profile photo updated successfully');
//         fetchProfileData(); // Refresh profile data after upload
//       } else {
//         throw Exception('Failed to update profile photo');
//       }
//     } catch (e) {
//       print('Error uploading profile photo: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile Page'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: photoUrl != null
//                       ? NetworkImage(photoUrl!)
//                       : const AssetImage('assets/placeholder.png') as ImageProvider,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   name ?? 'Guest User',
//                   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   email ?? 'No email available',
//                   style: const TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: uploadProfilePhoto,
//                   child: const Text('Upload Profile Photo'),
//                 ),
//                  const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: Signout(),
//                   child: const Text('Signout'),
//                 ),
//               ],
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/Authentication/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jpowered.pythonanywhere.com/account/'));
  String? photoUrl;
  String? name;
  String? email;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userId = prefs.getInt('user_id');

      if (token == null || userId == null) {
        throw Exception('Missing authentication token or user ID');
      }

      final response = await _dio.get(
        'userdetail/',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          name = '${data['first_name']} ${data['last_name']}';
          email = data['email'];
          photoUrl = data['photo_url'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> uploadProfilePhoto() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userId = prefs.getInt('user_id') ?? 0;

      if (token == null) {
        throw Exception('Missing authentication token');
      }

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      File photo = File(pickedFile.path);
      FormData formData = FormData.fromMap({
        "user": userId,
        'profile_photo': await MultipartFile.fromFile(photo.path, filename: 'photo.jpg'),
      });

      final response = await _dio.patch(
        'userdetail/',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Token $token',
        }),
      );

      if (response.statusCode == 200) {
        print('Profile photo updated successfully');
        fetchProfileData(); // Refresh profile data after upload
      } else {
        throw Exception('Failed to update profile photo');
      }
    } catch (e) {
      print('Error uploading profile photo: $e');
    }
  }

  Future<void> signout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved preferences
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Homescreen()),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: photoUrl != null
                      ? NetworkImage(photoUrl!)
                      : const AssetImage('assets/placeholder.png') as ImageProvider,
                ),
                const SizedBox(height: 16),
                Text(
                  name ?? 'Guest User',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  email ?? 'No email available',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: uploadProfilePhoto,
                  child: const Text('Upload Profile Photo'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: signout,
                  child: const Text('Signout'),
                ),
              ],
            ),
    );
  }
}


