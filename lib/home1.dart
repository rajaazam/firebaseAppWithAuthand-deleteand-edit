import 'dart:io';

import 'package:firebaseapp/drawer.dart';
import 'package:firebaseapp/post1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class Home1 extends StatefulWidget {
  // Stream?  postStream = FirebaseFirestore.instance.collection('posts').snapshots();
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late String imagePath;

  @override
  Widget build(BuildContext context) {
    void pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
     // print(image.path);
      //// basename=path.basename(image.path);

      setState(() {
        imagePath = image!.path;
      });
    }

    void submit() async {
      try {
        String title = titleController.text;
        String description = descriptionController.text;
        String imageName= path.basename(imagePath);
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('/$imageName');  //dart interplotion 
        File file = File(imagePath);
        await ref.putFile(file);
        String downloadURl = await ref.getDownloadURL();
         FirebaseFirestore db = FirebaseFirestore.instance;
         await db.collection("posts").add(
           {
             "title":title, "description":description,"url":downloadURl,
           }
         );
         
        print('post is upload  succcesfly');
        titleController.clear();
        descriptionController.clear();
       // print(downloadURl);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
     backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue,
           elevation: 0,
           actions: [
            //  Container(
            //      decoration: BoxDecoration(),
            // margin: EdgeInsets.only(right: 15, top: 15),
            // child: CircleAvatar(
            //   radius: 22,
            //   backgroundImage: AssetImage(
            //     "images/profile.jpg",
            //   ),
            // ),
            //  ),
             IconButton(onPressed: (){}, icon: Icon(Icons.search),),
             
           ],
        title:Text('Wellcome to Post App'),
        
      ),
      drawer: mydrawer(),
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
          ),
        ],
       ),
      
      body: Container(
       // color: Colors.deepOrange,
        margin: EdgeInsets.all(15),
          child: Column(
              
            children: [
        TextFormField(
          
          controller: titleController,
          style: TextStyle(fontSize: 30,),
          
          decoration: const InputDecoration(
           // fillColor: Colors.green,
           
            labelStyle: TextStyle(fontSize: 30),
            // icon: Icon(Icons.email),
            // counterStyle: TextStyle(fontSize: 30,
            // ),
            labelText: 'Enter title ',
          ),
          
        ),
        SizedBox(height: 15,),
        TextFormField(
          controller: descriptionController,
            style: TextStyle(fontSize: 30,),
          decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 30),
            // icon: Icon(Icons.email),
             //counterStyle: TextStyle(fontSize: 30,),
            labelText: 'Enter description',
          ),
        ),
        ElevatedButton(onPressed: pickImage, child: Text('pick image',style: TextStyle(fontSize: 20),),
        ),
        
        ElevatedButton(onPressed: submit, child: Text('submit',style: TextStyle(fontSize: 20),)),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream: posts.snapshots(),
            // stream: postStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      String id =document.id;
                      data["id"]=id;

                  return Post1(data: data);
                }).toList(),
              );
            },
          ),
        ))
      ])),
    );
  }
}
