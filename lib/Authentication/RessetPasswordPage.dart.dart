import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/Authentication/login.dart';
import 'package:skisubapp/home_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  final String uid;
  final String token;

  ResetPasswordPage({required this.uid, required this.token});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> resetPassword(String newPassword) async {
    final Dio dio = Dio();
    const String endpoint = "http://127.0.0.1:8000/account/reset-password/";

    try {
      Response response = await dio.post(
        endpoint,
        data: {
          "uid": widget.uid,
          "token": widget.token,
          "new_password": newPassword,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset successful.")),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to reset password: ${response.data}")),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.response?.data['detail'] ?? e.response?.data}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Connection error: ${e.message}")),
        );
      }
    }
  }

  void _submit() async {
    final newPassword = _passwordController.text.trim();

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a new password")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await resetPassword(newPassword);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password"),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to a specific screen (e.g., HomeScreen)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Enter your new password:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submit,
                    child: Text("Reset Password"),
                  ),
          ],
        ),
      ),
    );
  }
}