import 'package:extroverse/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future initSplash() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  void initState() {
    initSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF001F54), // Navy Tua
              Color(0xFF003566), // Biru Sedikit Lebih Terang
              Color(0xFF006494), // Biru Sedang
              Color(0xFF669BBC), // Biru Muda
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "WELCOME BACK!",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                "To Our Company",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: Image.asset(
                "assets/images/extroverse.png",
                height: 80, // Adjust this value to make the image smaller
              ),
            ),
          ],
        ),
      ),
    );
  }
}
