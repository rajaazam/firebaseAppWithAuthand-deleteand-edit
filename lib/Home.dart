import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'post.dart';


class Home extends StatelessWidget {
//  Stream postStream = FirebaseFirestore.instance.collection('posts').snapshots();
  //Stream<QuerySnapshot<Map<String, dynamic>>> postStream =       FirebaseFirestore.instance.collection('posts').snapshots();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(

        child:Column(
          children: [
            Text('data')
            //Post(),

          ],
        
        
        ),
      ),
      
    );
  }
}



