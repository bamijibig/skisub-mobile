import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/carscreen.dart';
import 'package:skisubapp/dashboard.dart';
import 'package:skisubapp/signup.dart';

class Homescreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
          'Login',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In 👋',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome back, Log in to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 30),
              // Email Field
              _inputField('Email', _emailController, isEmail: true),
              SizedBox(height: 20),
              // Password Field
              _inputField('Password', _passwordController, isPassword: true),
              SizedBox(height: 10),
              // Forgot Password Link
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Forgot Password Page
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Sign In Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed with login
                    _login(context);
                  }
                },
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.blue[800],
                ),
              ),
              SizedBox(height: 20),
              // Sign Up Link
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignupPage()));
                    // Navigate to Sign Up Page
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
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
        return null;
      },
    );
  }

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final loginPayload = {
      'username': email,
      'password': password,
    };

    try {
      // Create Dio instance
      final dio = Dio();

      // Make a POST request using Dio
      final response = await dio.post(
        'http://skis.eu-west-1.elasticbeanstalk.com/account/login/',
        data: loginPayload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Handle success response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CarBookingPage()),
        );
      }
    } on DioError catch (error) {
      // Log the response from the server
      if (error.response != null) {
        print('Error: ${error.response!.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Login failed: ${error.response!.data['detail'] ?? error.message}')),
        );
      } else {
        print('Error sending request: ${error.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${error.message}')),
        );
      }
    } catch (error) {
      // Handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $error')),
      );
    }
  }
}
