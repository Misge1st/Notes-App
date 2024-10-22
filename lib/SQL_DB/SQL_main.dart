// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/SQL_DB/page/notes_page.dart';
// import 'package:flutter_application_1/log_in.dart';
// import 'package:flutter_application_1/rou_hts.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   Platform.isAndroid
//       ? await Firebase.initializeApp(
//           options: const FirebaseOptions(
//             apiKey: "AIzaSyD8T6OhL2_6THW-fL1G_bjKQOxLwccYe5M",
//             appId: "1:520316586963:android:cd763b4c06ac64b1e23d26",
//             messagingSenderId: "520316586963",
//             projectId: "flutter1-cc9c7",
//           ),
//         )
//       : await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const LoginView(),
//       routes: {
//         loginRoute: (context) => const LoginView(),
//         // registerRoute: (context) => const Registerview(),
//         // verifyRoute: (context) => const VerifyEmailView(),
//         // mynewhome: (context) => const Homepage(),
//         notes: (context) => const NotesPage(),
//       },
//     );
//   }
// }
