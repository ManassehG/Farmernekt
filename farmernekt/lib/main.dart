import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import for Firebase initialization
import 'bottom_nav.dart';
import 'package:farmernekt/screens/login_screen.dart';
import 'firebase_options.dart';
import 'navigation-components/user-details.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that plugin services are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmerNekt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),

      debugShowCheckedModeBanner: false, // Remove debug banner
      home: AuthWrapper(),
      routes: {
        '/login': (context) => LoginPage(),
        '/userdetails': (context) => UserDetailsPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return BottomNav();
        }
        return LoginPage();
      },
    );
  }
}
