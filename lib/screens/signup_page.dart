import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Now used in the UI

  Future<PostgreSQLConnection> connectToDatabase() async {
    var connection = PostgreSQLConnection(
      'your_host', // e.g., 'localhost'
      5432,
      'your_database',
      username: 'your_username',
      password: 'your_password',
    );
    await connection.open();
    return connection;
  }

  Future<void> signUp() async {
    if (!mounted) return; // Ensure widget is still in the tree

    setState(() => _isLoading = true);

    try {
      final conn = await connectToDatabase();

      await conn.query(
        'INSERT INTO users (name, email, password) VALUES (@name, @email, @password)',
        substitutionValues: {
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      await conn.close();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create account')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {  // Missing build() was added
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
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
                ? const CircularProgressIndicator() // Now correctly used
                : ElevatedButton(
              onPressed: signUp,
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
