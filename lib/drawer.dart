import 'package:flutter/material.dart';



class mydrawer extends StatefulWidget {
  const mydrawer({ Key? key }) : super(key: key);

  @override
  _mydrawerState createState() => _mydrawerState();
}

class _mydrawerState extends State<mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [

   UserAccountsDrawerHeader(accountName: Text('username'),
   
    accountEmail: Text('kacho@gmail.com'),
    currentAccountPicture: CircleAvatar(
    child: Text('KR')

    ),   
    ),
ListTile(
leading: Icon(Icons.person_outline),
title: Text('Accont'),
onTap: (){},


),

ListTile(
  leading: Icon(Icons.email_sharp),
  title: Text('Email'),
),

ListTile(
  leading: Icon(Icons.call),
  title: Text('Contact'),

),

ListTile(

leading: Icon(Icons.settings_applications),
title: Text('Settings'),

),

ListTile(



),


ListTile(

leading: Icon(Icons.logout),
title:
Text('Log out'),

)
      ],),
    );
  }
}