import 'package:flutter/material.dart';
import 'package:module_04/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module_04/views/home.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DiaryApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        primaryColor: Colors.white,
        useMaterial3: true,
      ),
      
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const Home(),
      },
    );
  }
}
