import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class editPage extends StatefulWidget {
  final Map data;
  editPage({required this.data});

  @override
  _editPageState createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  late String imagePath;
   TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
  @override
  void initState(){
    super.initState();
    titleController.text=widget.data["title"];
    descriptionController.text=widget.data["description"];
  }
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
    void done()async{
      try{
        String imageName= path.basename(imagePath);
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('/$imageName');  //dart interplotion 
        File file = File(imagePath);
        await ref.putFile(file);
        String downloadURl = await ref.getDownloadURL();
         FirebaseFirestore db = FirebaseFirestore.instance;
       Map<String,dynamic> newPost={
         "title":titleController.text,
         "description":descriptionController.text,
         "url":downloadURl,
       };
       await db.collection("posts").doc(widget.data["id"]).set(newPost);
       Navigator.of(context).pop();
      }catch(e){
        print(e);
      }
    }
    return AlertDialog(
      content: Container(child: Column(
 mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
                controller: titleController,
                 style: TextStyle(fontSize: 20,),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 10,),
                 // icon: Icon(Icons.person),
                  labelText: 'Enter title',
                ),
              ),

 TextFormField(
                controller: descriptionController,
                style: TextStyle(fontSize: 20,),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 15),
                 //icon: Icon(Icons.person),
                  labelText: 'Enter description',
                ),
              ),
              ElevatedButton(onPressed: pickImage, child: Text('pick an image',style: TextStyle(fontSize: 15),)),
              ElevatedButton(onPressed: done, child: Text('done',style: TextStyle(fontSize: 15),)),

        ],
      ),),
      
    );
  }
}