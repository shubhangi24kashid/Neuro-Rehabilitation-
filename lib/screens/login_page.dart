import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<PostgreSQLConnection> connectToDatabase() async {
    var connection = PostgreSQLConnection(
      'your_host',
      5432,
      'your_database',
      username: 'your_username',
      password: 'your_password',
    );
    await connection.open();
    return connection;
  }

  Future<void> login() async {
    setState(() => _isLoading = true);
    final conn = await connectToDatabase();
    try {
      var result = await conn.query(
        'SELECT * FROM users WHERE email = @email AND password = @password',
        substitutionValues: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );
      if (result.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await conn.close();
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: login, child: const Text('Login')),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
