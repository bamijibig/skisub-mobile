import 'package:flutter/material.dart';
import 'package:skisubapp/homescreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context).push(MaterialPageRoute
      (builder :(context)=>Homescreen(),
      ));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: Colors.white,
        child: Column(
          children: [
            Image.asset('assets/images/splashimage.png',
            width: 300,
            ),
            const Text('skisub',
            style: TextStyle(
              color: Colors.black
            ),)
          ],
        ),
      ),
    );
  }
}