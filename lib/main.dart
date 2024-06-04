import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_mate/Screens/home.dart';
import 'package:student_mate/students_provider.dart';
import 'Screens/login_page.dart';
import 'Screens/signup_page.dart';
import 'Screens/students_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => const MyHomePage(),
          '/student': (context) => const StudentsPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
        },
      ),
    );
  }
}
