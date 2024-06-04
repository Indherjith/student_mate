import 'package:flutter/material.dart';
import '../Components/showdialog.dart';
import '../auth_service.dart'; // Adjust the path as necessary

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                final user = await _authService.signInWithEmailAndPassword(
                    email, password);
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Handle login error
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () async {
                final email = _emailController.text;
                try {
                  await _authService.sendPasswordResetEmail(email);
                  showAlertDialog(context, "Reset Password",
                      "Password reset link is sent to your registered email address.");
                } catch (e) {
                  showAlertDialog(context, "Error", e.toString());
                }
              },
              child: const Text(
                  'Forgot Password? please enter email on email input field'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: const Text('New User? Sign-up here'),
            ),
          ],
        ),
      ),
    );
  }
}
