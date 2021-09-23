
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class singup extends StatelessWidget {
  const singup({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
      void Register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String username = nameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await db.collection("users").doc(user.user!.uid).set({
          "email": email,
          "username": username,
        });
        print("Register done");
      } catch (e) {
        print(e);
      }
    }
    return Scaffold(
      body: Container(
        child: SafeArea(child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'User Name *',
                ),
              ),

              //2
               TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'User Email *',
                ),
              ),
              //3
               TextFormField(
                controller:passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'User Password *',
                ),
              ),
              ElevatedButton(onPressed: Register, child: Text('Register'))
          ],
        )
        ),
      ),
      
    );
  }
}