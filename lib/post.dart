import 'package:flutter/material.dart';

class Post extends StatefulWidget {


  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network('https://img.apester.com/insecure/fit/700/0/ce/0/plain/user-images%2F7e%2F7e215ee954e65c80849aa9cc94bb4037.jpg',
           
            width: 100,
            height: 100,
          ),
          Text('quaid azam'),
          Text('founder of pak'),
        ],
      ),
    );
  }
}
