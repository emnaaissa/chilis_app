import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/screens/screens.dart';
import 'package:frontend/screens/dashboard_screen.dart';
import 'package:frontend/networking/firebase_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notifications
  await FirebaseNotifications().initNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DashboardScreen(
        onSelectScreen: (Screens screen) {
          // handle screen navigation logic here
        },
      ),
    );
  }
}
