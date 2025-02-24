import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart'; // ✅ Correct import
import 'screens/home_page.dart';
import 'screens/survey_page.dart';
import 'screens/rehab_selection_page.dart';
import 'screens/game_page.dart';

void main() {
  runApp(const HealXperienceApp());
}

class HealXperienceApp extends StatelessWidget {
  const HealXperienceApp({super.key}); // ✅ Fixed typo & ensured key usage

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealXperience',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // ✅ StatelessWidget (can be const)
        '/login': (context) => const LoginPage(), // ✅ StatelessWidget (can be const)
        '/signup': (context) => SignUpPage(), // ❌ Removed `const` (StatefulWidget)
        '/home': (context) => const HomePage(), // ✅ StatelessWidget (can be const)
        '/survey': (context) => SurveyPage(), // ❌ Removed `const` (StatefulWidget)
        '/rehab_selection': (context) => RehabSelectionPage(), // ❌ Removed `const` (StatefulWidget)
        '/game_selection': (context) => GameSelectionPage(), // ❌ Removed `const` (StatefulWidget)
      },
    );
  }
}
