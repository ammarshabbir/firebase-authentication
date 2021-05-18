import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are logged in'),
              SizedBox(height: 10),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('logout'),
                  onPressed: (){
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.of(context).pushNamed('/landingPage');
                  }).catchError((e){
                    print(e);
                  });
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
