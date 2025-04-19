import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/login_page.dart';
import 'home/message_boards_page.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Board App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define the initial screen (Splash Screen)
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/messageBoards': (context) => MessageBoardsPage(),
      },
    );
  }
}
