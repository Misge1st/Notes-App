import 'dart:io';

import 'package:doctor_1/SQL_DB/page/notes_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyD8T6OhL2_6THW-fL1G_bjKQOxLwccYe5M",
            appId: "1:520316586963:android:cd763b4c06ac64b1e23d26",
            messagingSenderId: "520316586963",
            projectId: "flutter1-cc9c7",
            storageBucket: 'flutter1-cc9c7.appspot.com',
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MainApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MainApp();
  }
}

class MainApp extends StatelessWidget {
  static String title = 'Notes SQLite';

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const NotesPage(),
    );
  }
}
