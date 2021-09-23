import 'package:firebaseapp/Home.dart';
import 'package:firebaseapp/home1.dart';
import 'package:firebaseapp/login.dart';
import 'package:firebaseapp/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
            
            home: login(),
            routes:{
              "/login" :(context)=>login(),
              "/Register": (context)=> singup(),
              "/home":(context)=>Home(),
              "/home1":(context)=>Home1()

            }
            
            );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
