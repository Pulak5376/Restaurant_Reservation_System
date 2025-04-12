import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main.dart'; // For UserDataStore

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();

  bool _isLoading = false;

  // In-memory user storage
  final Map<String, Map<String, String>> _userDatabase =
      UserDataStore.getUserData('users') ?? {};

  Future<void> _registerUser() async {
    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();
      final role = _roleController.text.trim().toLowerCase();

      if (email.isEmpty || password.isEmpty || name.isEmpty || role.isEmpty) {
        throw Exception('All fields are required');
      }

      if (role != 'user' && role != 'manager') {
        throw Exception('Role must be either "user" or "manager"');
      }

      if (_userDatabase.containsKey(email)) {
        throw Exception('User with this email already exists');
      }

      // Save user data in the in-memory database
      _userDatabase[email] = {'name': name, 'password': password, 'role': role};

      // Store the updated user database in UserDataStore
      UserDataStore.saveUserData('users', _userDatabase);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration_successful!')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration_failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: _roleController,
              decoration: const InputDecoration(
                labelText: 'Role (user/manager)',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _registerUser,
                  child: const Text('Register'),
                ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
