import 'package:flutter/material.dart';
import '/services/api_service.dart'; // Import API service
import 'screens/splash_screen.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/home_page.dart';
import 'screens/survey_page.dart';
import 'screens/rehab_selection_page.dart';
import 'screens/game_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await ApiService.getToken();
  runApp(HealXperienceApp(isLoggedIn: token != null));
}

class HealXperienceApp extends StatelessWidget {
  final bool isLoggedIn;

  const HealXperienceApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealXperience',
      debugShowCheckedModeBanner: false, // ✅ Hide debug banner
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: isLoggedIn ? '/home' : '/login', // ✅ Redirect based on auth status
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => SignUpPage(), // ❌ Removed `const`
        '/home': (context) => const HomePage(),
        '/survey': (context) => SurveyPage(), // ❌ Removed `const`
        '/rehab_selection': (context) => RehabSelectionPage(), // ❌ Removed `const`
        '/game_selection': (context) => GameSelectionPage(), // ❌ Removed `const`
      },
    );
  }
}
