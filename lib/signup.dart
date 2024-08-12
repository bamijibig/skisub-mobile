import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/carbooking.dart';
import 'package:skisubapp/carscreen.dart';
import 'package:skisubapp/homescreen.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Register',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                // Full Name Field
                _inputField('Full Name', _fullNameController),
                SizedBox(height: 20),
                // Email Field
                _inputField('Email', _emailController, isEmail: true),
                SizedBox(height: 20),
                // Phone Number Field
                _inputField('Phone Number', _phoneNumberController),
                SizedBox(height: 20),
                // Password Field
                _inputField('Password', _passwordController, isPassword: true),
                SizedBox(height: 20),
                // Confirm Password Field
                _inputField('Confirm Password', _confirmPasswordController,
                    isPassword: true),
                SizedBox(height: 30),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, proceed with signup
                      _signup(context);
                    }
                  },
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    // primary: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 20),
                // Login Link
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to Login Page
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
    );
  }

  Widget _inputField(String hint, TextEditingController controller,
      {bool isPassword = false, bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
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
            ? Icon(Icons.visibility_off, color: Colors.grey)
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hint';
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (hint == 'Confirm Password' &&
            value != _passwordController.text) {
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

    // Split full name into first and last names
    final names = fullName.split(' ');
    final firstName = names[0];
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

    // Create a User object
    final user = User(
      email: email,
      password: password,
      password2: confirmPassword,
      username: email, // You can change this if needed
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    try {
      // Make a POST request using Dio
      final response = await Dio().post(
        'http://skis.eu-west-1.elasticbeanstalk.com/account/signup/',
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Handle success response
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful!')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homescreen()),
        );
      }
    } catch (error) {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $error')),
      );
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
