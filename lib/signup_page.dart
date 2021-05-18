import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String _email;
  String _password;
  bool progress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    onChanged: (value){
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    onChanged: (value){
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    elevation: 7.0,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Sign Up'),
                    onPressed: (){
                      setState(() {
                        progress = true;
                      });
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _email,
                          password: _password).then((SignedInUser ) {
                            setState(() {
                              progress = false;
                            });
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed('/homePage');
                      }).catchError((e){
                        print(e);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
