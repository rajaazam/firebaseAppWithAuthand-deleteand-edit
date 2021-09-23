import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/edit.dart';
import 'package:firebaseapp/post.dart';
import 'package:flutter/material.dart';
class Post1 extends StatelessWidget {
  final Map data;
  Post1({required this.data});


  @override
  Widget build(BuildContext context) {
  void deletePost()async{
    try{
           FirebaseFirestore db = FirebaseFirestore.instance;
          await  db.collection("posts").doc(data["id"]).delete();

    }catch(e){
      print(e);
    }
       }
     void editPost(){
      showDialog(context: context, builder: (BuildContext  context){
        return editPage(data: data,);

      });

  }
    
    return Container(
            margin: EdgeInsets.only(top: 10),
            
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        border: Border.all(color: Colors.black, width: 1),
        
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(data["url"],
           
            width: 250,
            height: 250,
            fit: BoxFit.cover,
            
          ),
          Text(data["title"]),
          Text(data["description"]),
          ElevatedButton(onPressed: deletePost, child: Text('Delete')),
          ElevatedButton(onPressed: editPost, child:Text('Edit'))
        
        ],
      ),

      
    );
  }
}