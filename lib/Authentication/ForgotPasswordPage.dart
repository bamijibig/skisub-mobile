import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/Authentication/RessetPasswordPage.dart.dart';
import 'package:skisubapp/Authentication/login.dart';



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

 
Future<void> sendPasswordResetRequest(String email) async {
  final Dio dio = Dio();
  const String endpoint = "http://127.0.0.1:8000/account/forgot-password/";

  try {
    Response response = await dio.post(
      endpoint,
      data: {"email": email},
    );

    if (response.statusCode == 200) {
      final uid = response.data['uid'];
      final token = response.data['token'];

      // Navigate to ResetPasswordPage with the UID and Token
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResetPasswordPage(uid: uid, token: token),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send reset request: ${response.data}")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${e.toString()}")),
    );
  }
}
void _submit() async {
  final email = _emailController.text.trim();

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
    await sendPasswordResetRequest(email);
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password"),
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
                    child: Text("Send Reset Email",
                    style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                        style: ElevatedButton.styleFrom(
                          
                          backgroundColor: Color.fromRGBO(16, 0, 199, 1),
                          minimumSize: Size(double.infinity, 50),
                        ),),
                  
                  
          ],
        ),
      ),
    );
  }
}
