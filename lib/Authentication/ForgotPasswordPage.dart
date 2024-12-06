import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/Authentication/RessetPasswordPage.dart.dart';



class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  // Email validation regex pattern
  bool isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final Dio dio = Dio();
    const String endpoint = "https://skissub.pythonanywhere.com/account/forgot-password/";

    try {
      Response response = await dio.post(
        endpoint,
        data: {
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset email sent successfully.")),
        );

        // Navigate to the Reset Password Page immediately
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResetPasswordPage(uid: '', token: '',), // No parameters needed
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send reset email: ${response.data}")),
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
    final email = _emailController.text.trim();

    // Validate the email format
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email address")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // await sendPasswordResetEmail(email);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Enter your email to reset your password:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submit,
                    child: Text("Send Reset Email"),
                  ),
          ],
        ),
      ),
    );
  }
}
