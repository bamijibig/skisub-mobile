// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:skisubapp/CarApp/carbooking.dart';
// import 'package:skisubapp/CarApp/carscreen.dart';
// import 'package:skisubapp/Authentication/login.dart';

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false; // Loading state

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         // leading: IconButton(
//         //   icon: Icon(Icons.arrow_back, color: Colors.black),
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   },
//         // ),
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Register',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Get Started 👋',
//                       style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Create an account so you can pay your bills and purchase top-ups faster',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     ),
//                     SizedBox(height: 30),
//                     _inputField('Full Name', _fullNameController),
//                     SizedBox(height: 20),
//                     _inputField('Email', _emailController, isEmail: true),
//                     SizedBox(height: 20),
//                     _inputField('Phone Number', _phoneNumberController),
//                     SizedBox(height: 20),
//                     _inputField('Password', _passwordController, isPassword: true),
//                     SizedBox(height: 20),
//                     _inputField('Confirm Password', _confirmPasswordController, isPassword: true),
//                     SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _signup(context);
//                         }
//                       },
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromRGBO(16, 0, 199, 1),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Align(
//                       alignment: Alignment.center,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: RichText(
//                           text: TextSpan(
//                             text: 'Have an account? ',
//                             style: TextStyle(color: Colors.black, fontSize: 14),
//                             children: [
//                               TextSpan(
//                                 text: 'Login Here',
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _inputField(String hint, TextEditingController controller,
//       {bool isPassword = false, bool isEmail = false}) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//       decoration: InputDecoration(
//         hintText: hint,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.grey[200],
//         suffixIcon: isPassword ? Icon(Icons.visibility_off, color: Colors.grey) : null,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your $hint';
//         }
//         if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//           return 'Please enter a valid email';
//         }
//         if (hint == 'Confirm Password' && value != _passwordController.text) {
//           return 'Passwords do not match';
//         }
//         return null;
//       },
//     );
//   }

//   Future<void> _signup(BuildContext context) async {
//     final fullName = _fullNameController.text.trim();
//     final email = _emailController.text.trim();
//     final phoneNumber = _phoneNumberController.text.trim();
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;

//     // Split full name into first and last names
//     final names = fullName.split(' ');
//     final firstName = names[0];
//     final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

//     // Create a User object
//     final user = User(
//       email: email,
//       password: password,
//       password2: confirmPassword,
//       username: email,
//       firstName: firstName,
//       lastName: lastName,
//       phoneNumber: phoneNumber,
//     );

//     setState(() {
//       _isLoading = true; // Show progress indicator
//     });

//     try {
//       final response = await Dio().post(
//         'https://jpowered.pythonanywhere.com/account/signup/',
//         data: user.toJson(),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Signup successful!')),
//         );
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => Homescreen()),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Signup failed: $error')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false; // Hide progress indicator
//       });
//     }
//   }
// }

// class User {
//   final String email;
//   final String password;
//   final String password2;
//   final String username;
//   final String firstName;
//   final String lastName;
//   final String phoneNumber;

//   User({
//     required this.email,
//     required this.password,
//     required this.password2,
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     required this.phoneNumber,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'email': email,
//       'password': password,
//       'password2': password2,
//       'username': username,
//       'first_name': firstName,
//       'last_name': lastName,
//       'phone_number': phoneNumber,
//     };
//   }
// }
// 
// 
// 

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/CarApp/carbooking.dart';
import 'package:skisubapp/CarApp/carscreen.dart';
import 'package:skisubapp/Authentication/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

// class _SignupPageState extends State<SignupPage> {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false; // Loading state

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Register',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Get Started 👋',
//                       style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Create an account so you can pay your bills and purchase top-ups faster',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     ),
//                     SizedBox(height: 30),
//                     _inputField('Full Name', _fullNameController),
//                     SizedBox(height: 20),
//                     _inputField('Email', _emailController, isEmail: true),
//                     SizedBox(height: 20),
//                     _inputField('Phone Number', _phoneNumberController),
//                     SizedBox(height: 20),
//                     _inputField('Password', _passwordController, isPassword: true),
//                     SizedBox(height: 20),
//                     _inputField('Confirm Password', _confirmPasswordController, isPassword: true),
//                     SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _signup(context);
//                         }
//                       },
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromRGBO(16, 0, 199, 1),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Align(
//                       alignment: Alignment.center,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: RichText(
//                           text: TextSpan(
//                             text: 'Have an account? ',
//                             style: TextStyle(color: Colors.black, fontSize: 14),
//                             children: [
//                               TextSpan(
//                                 text: 'Login Here',
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _inputField(String hint, TextEditingController controller,
//     {bool isPassword = false, bool isEmail = false}) {
//   return TextFormField(
//     controller: controller,
//     obscureText: isPassword,
//     keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//     decoration: InputDecoration(
//       hintText: hint,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: BorderSide.none,
//       ),
//       filled: true,
//       fillColor: Colors.grey[200],
//       suffixIcon: isPassword ? Icon(Icons.visibility_off, color: Colors.grey) : null,
//     ),
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Please enter your $hint';
//       }
//       if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//         return 'Please enter a valid email';
//       }
//       if (isPassword && value.length < 8) {
//         return 'Password must be at least 8 characters';
//       }
//       if (hint == 'Confirm Password' && value != _passwordController.text) {
//         return 'Passwords do not match';
//       }
//       return null;
//     },
//   );
// }
class _SignupPageState extends State<SignupPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state

  // State for password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Register',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Started 👋',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Create an account so you can pay your bills and purchase top-ups faster',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 30),
                    _inputField('Full Name', _fullNameController),
                    SizedBox(height: 20),
                    _inputField('Email', _emailController, isEmail: true),
                    SizedBox(height: 20),
                    _inputField('Phone Number', _phoneNumberController),
                    SizedBox(height: 20),
                    _inputField(
                      'Password',
                      _passwordController,
                      isPassword: true,
                      isVisible: _isPasswordVisible,
                      toggleVisibility: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    _inputField(
                      'Confirm Password',
                      _confirmPasswordController,
                      isPassword: true,
                      isVisible: _isConfirmPasswordVisible,
                      toggleVisibility: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signup(context);
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(16, 0, 199, 1),
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Have an account? ',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Login Here',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
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
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller,
      {bool isPassword = false, bool isEmail = false, bool isVisible = false, VoidCallback? toggleVisibility}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isVisible,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: toggleVisibility,
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hint';
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (isPassword && value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (hint == 'Confirm Password' && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }


  Future<void> _signup(BuildContext context) async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Split full name into first and last names
    final names = fullName.split(' ');
    final firstName = names[0];
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

    // Create a User object
    final user = User(
      email: email,
      password: password,
      password2: confirmPassword,
      username: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Dio().post(
        'https://jpowered.pythonanywhere.com/account/signup/',
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful!')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homescreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed. Please try again.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class User {
  final String email;
  final String password;
  final String password2;
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  User({
    required this.email,
    required this.password,
    required this.password2,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password2': password2,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
    };
  }
}
