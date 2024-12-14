// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';
// import 'dart:io';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:skisubapp/Authentication/login.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/account/'));
//   String? photoUrl;
//   String? name;
//   String? email;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProfileData();
//   }

//   // Fetch profile data from API
//   Future<void> fetchProfileData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');

//       if (token == null) {
//         throw Exception('Missing authentication token');
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
//           photoUrl = data['photo_url'] != null && data['photo_url'].startsWith('http')
//               ? data['photo_url']
//               : 'http://127.0.0.1:8000${data['photo_url']}';
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

// Future<void> uploadProfilePhoto() async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('auth_token');

//     if (token == null) {
//       throw Exception('Missing authentication token');
//     }

//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile == null) return;

//     File photo = File(pickedFile.path);
//     FormData formData = FormData.fromMap({
//       'profile_photo': await MultipartFile.fromFile(photo.path, filename: 'profile_photo.jpg'),
//     });

//     final response = await _dio.post(
//       'upload-photo/',
//       data: formData,
//       options: Options(headers: {
//         'Authorization': 'Token $token',
//         'Content-Type': 'multipart/form-data',
//       }),
//     );

//     if (response.statusCode == 201) {
//       print('Profile photo updated successfully');
//       // Update profile photo immediately
//       setState(() {
//         photoUrl = response.data['file_url'];
//       });
//     } else {
//       throw Exception('Failed to update profile photo');
//     }
//   } catch (e) {
//     print('Error uploading profile photo: $e');
//   }
// }


//   // Sign out the user
//   Future<void> signout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear(); // Clear all saved preferences
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => Homescreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile Page'),
//         automaticallyImplyLeading: false,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   // Show profile photo (ensure it's dynamically loaded)
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: photoUrl != null && photoUrl!.isNotEmpty
//                         ? NetworkImage(photoUrl!) // Dynamic image loading
//                         : const AssetImage('assets/placeholder.png') as ImageProvider,
//                     onBackgroundImageError: (_, __) {
//                       print('Error loading profile photo');
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     name ?? 'Guest User',
//                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     email ?? 'No email available',
//                     style: const TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: uploadProfilePhoto,
//                     child: const Text('Upload Profile Photo'),
//                   ),
//                   const SizedBox(height: 20),
//                   // Personal Information Section
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to personal information page
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: Colors.grey[300]!),
//                         ),
//                       ),
//                       child: Row(
//                         children: const [
//                           Icon(Icons.person, color: Colors.black),
//                           SizedBox(width: 16.0),
//                           Expanded(
//                             child: Text(
//                               'Personal Information',
//                               style: TextStyle(fontSize: 16.0, color: Colors.black),
//                             ),
//                           ),
//                           Icon(Icons.arrow_forward_ios, color: Colors.black),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Settings Section
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to settings page
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: Colors.grey[300]!),
//                         ),
//                       ),
//                       child: Row(
//                         children: const [
//                           Icon(Icons.settings, color: Colors.black),
//                           SizedBox(width: 16.0),
//                           Expanded(
//                             child: Text(
//                               'Settings',
//                               style: TextStyle(fontSize: 16.0, color: Colors.black),
//                             ),
//                           ),
//                           Icon(Icons.arrow_forward_ios, color: Colors.black),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Signout Section
//                   ElevatedButton(
//                     onPressed: signout,
//                     child: const Text('Signout'),
//                   ),
//                 ],
//               ),
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
import 'package:skisubapp/profile/HelpandSupportPage.dart';
import 'package:skisubapp/profile/profileEditPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/account/'));
  String? photoUrl;
  String? name;
  String? email;
  String? phone;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  // Fetch profile data from API
  Future<void> fetchProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Missing authentication token');
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
          phone = data['phone_number'];
          photoUrl = data['photo_url'] != null && data['photo_url'].startsWith('http')
              ? data['photo_url']
              : 'http://127.0.0.1:8000${data['photo_url']}';
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

      if (token == null) {
        throw Exception('Missing authentication token');
      }

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      File photo = File(pickedFile.path);
      FormData formData = FormData.fromMap({
        'profile_photo': await MultipartFile.fromFile(photo.path, filename: 'profile_photo.jpg'),
      });

      final response = await _dio.post(
        'upload-photo/',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'multipart/form-data',
        }),
      );

      if (response.statusCode == 201) {
        print('Profile photo updated successfully');
        // Update profile photo immediately
        setState(() {
          photoUrl = response.data['file_url'];
        });
      } else {
        throw Exception('Failed to update profile photo');
      }
    } catch (e) {
      print('Error uploading profile photo: $e');
    }
  }

  // Sign out the user
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
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Show profile photo (ensure it's dynamically loaded)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: photoUrl != null && photoUrl!.isNotEmpty
                        ? NetworkImage(photoUrl!) // Dynamic image loading
                        : const AssetImage('assets/placeholder.png') as ImageProvider,
                    onBackgroundImageError: (_, __) {
                      print('Error loading profile photo');
                    },
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
                  const SizedBox(height: 20),
                  // Personal Information Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfilePage(
                        name: name ?? 'Guest User', // Pass the user's name or a fallback value
                        phone: phone ?? 'No phone Available', // Pass phone number or fallback value
                        email: email ?? 'No email available', // Pass email or fallback value
                        )),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.person, color: Colors.black),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              'Personal Information',
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Settings Section
                  GestureDetector(
                    onTap: () {
                      // Show signout option in a modal bottom sheet
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.logout, color: Colors.red),
                                  title: const Text(
                                    'Signout',
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context); // Close the bottom sheet
                                    signout(); // Call the signout method
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.settings, color: Colors.black),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              'Settings',
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black),
                          
                        ],
                      ),
                      
                    ),
                  ),
                  // Personal Information Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpAndSupportPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.person, color: Colors.black),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              'Help and Support',
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
                
                
              ),
            ),
    );
  }
}
