
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/Authentication/ForgotPasswordPage.dart';
import 'package:skisubapp/dashboard.dart';
import 'package:skisubapp/home_screen.dart';
import 'package:skisubapp/Authentication/signup.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state
  bool _obscurePassword = true; // State to control password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
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
                  _inputField('Email', _emailController, isEmail: true),
                  SizedBox(height: 20),
                  _inputField('Password', _passwordController, isPassword: true),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Forgot Password Page
                        Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color.fromRGBO(16, 0, 199, 1), fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login(context);
                      }
                    },
                    child: Text(
                      'Sign In',
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
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignupPage()));
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
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller,
      {bool isPassword = false, bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false, // Toggle visibility
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
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword; // Toggle password visibility
                  });
                },
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

    setState(() {
      _isLoading = true; // Show progress indicator
    });

    try {
      final dio = Dio();
      final response = await dio.post(
        'http://127.0.0.1:8000/account/login/',
        data: loginPayload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        final userId = data['data']['id'];

        // Store token and user ID in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setInt('user_id', userId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      }
    } on DioError catch (error) {
      if (error.response != null && error.response!.statusCode == 401) {
        // Handle incorrect credentials
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect email or password')),
        );
      } else if (error.response != null && error.response!.statusCode == 400) {
        // Handle validation errors
        final errorMessage = error.response!.data['detail'] ??
            'Invalid Password, use alphanumeric only';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          // SnackBar(content: Text('Unable to log in. Please try again later.')),
          SnackBar(content: Text('Invalid Password, use alphanumeric only')),
           
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Password, use alphanumeric only')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide progress indicator
      });
    }
  }
}
