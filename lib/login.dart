import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: "azam0@gmail.com");
    TextEditingController passwordController =
        TextEditingController(text: "123456");
    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String email = emailController.text;
      final String password = passwordController.text;

      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        final DocumentSnapshot snapshot =
            await db.collection("users").doc(user.user!.uid).get();
        final data = snapshot.data();
        Navigator.of(context).pushNamed("/home1",arguments:data);
      } catch (e) {
        print("eror");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("${e}"),
              );
            });
        // print(e);

      }
    }

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //2
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'User Emal *',
                ),
              ),
              //3
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'User Password *',
                ),
              ),
              //btn
              ElevatedButton(onPressed: login, child: Text('Log In'))
            ],
          ),
        ),
      ),
    );
  }
}
