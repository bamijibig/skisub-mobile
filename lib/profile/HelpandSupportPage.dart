import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // To handle external links

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  // Function to open URLs
  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Chat Icon
            Center(
              child: Image.asset(
                'assets/icons/chat_icon.png', // Replace with actual path
                height: 120,
                width: 120,
              ),
            ),

            const SizedBox(height: 20),

            // Title and Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'How can we help you ?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "At Ski Sub, we're committed to providing you with the best possible experience. If you have any questions, concerns, or issues, we're here to help.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Social Media Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialMediaButton(
                        imagePath: 'assets/icons/instagram.png',
                        title: 'Instagram',
                        subtitle: '@skisub',
                        url: 'https://instagram.com/skisub',
                      ),
                      _buildSocialMediaButton(
                        imagePath: 'assets/icons/whatsapp.png',
                        title: 'WhatsApp',
                        subtitle: 'Click Here',
                        url: 'https://wa.me/1234567890', // Replace with your number
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialMediaButton(
                        imagePath: 'assets/icons/telegram.png',
                        title: 'Telegram',
                        subtitle: '@skisub',
                        url: 'https://t.me/skisub',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build social media buttons
  Widget _buildSocialMediaButton({
    required String imagePath,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        width: 160,
        height: 120,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 36,
              width: 36,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
