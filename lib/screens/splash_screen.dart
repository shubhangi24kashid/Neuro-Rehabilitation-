import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    final BuildContext contextBeforeDelay = context; // ✅ Store context before async call

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return; // ✅ Ensure widget is still in the tree

    Navigator.pushReplacementNamed(contextBeforeDelay, '/login'); // ✅ Now safe to use context
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Ensure logo is in 'assets' folder
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'HealXperience',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Play | Heal | Thrive',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
