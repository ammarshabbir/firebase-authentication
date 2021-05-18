import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email;
  String _password;
  bool progress = false;

  Future<UserCredential> signInWithGoogle() async {
    setState(() {
      progress = true;
    });
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  Future<UserCredential> signInWithFacebook() async {
    setState(() {
      progress = true;
    });
    // Trigger the sign-in flow
    final AccessToken result = (await FacebookAuth.instance.login()) as AccessToken;

    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
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
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Login'),
                      color: Colors.blue,
                      elevation: 7.0,
                      textColor: Colors.white,
                      onPressed: (){
                      setState(() {
                        progress = true;
                      });
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email,
                          password: _password,

                      ).then((value) {
                        setState(() {
                          progress = false;
                        });
                        Navigator.of(context).pushNamed('/homePage');
                      } );
                      }
                  ),
                  SizedBox(height:10),
                  RaisedButton(
                      child: Text('Google'),
                      color: Colors.blue,
                      elevation: 7.0,
                      textColor: Colors.white,
                      onPressed: (){
                        signInWithGoogle().then((value) {
                          setState(() {
                            progress = false;
                          });
                          Navigator.of(context).pushNamed('/homePage');
                        }).catchError((e){
                          print(e);
                        });
                      }
                  ),
                  SizedBox(height:10),
                  RaisedButton(
                      child: Text('facebook'),
                      color: Colors.blue,
                      elevation: 7.0,
                      textColor: Colors.white,
                      onPressed: (){
                        signInWithFacebook().then((value) {
                          setState(() {
                            progress = false;
                            Navigator.of(context).pushNamed('/homePage');
                          });
                        }).catchError((e){
                          print(e);
                        });
                      }
                  ),
                  RaisedButton(
                      child: Text('anonymous'),
                      color: Colors.blue,
                      elevation: 7.0,
                      textColor: Colors.white,
                      onPressed: (){
                       FirebaseAuth.instance.signInAnonymously().then((user) {
                         Navigator.of(context).pushReplacementNamed('/homePage');
                       }).catchError((e){
                         print(e);
                       });
                      }
                  ),
                  SizedBox(height: 5),
                  Text('Dont have an account'),
                  RaisedButton(
                    elevation: 7.0,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Sign Up'),
                    onPressed: (){
                      Navigator.of(context).pushNamed('/signupPage');
                    },
                  ),
                  RaisedButton(
                    elevation: 7.0,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Login with phone'),
                    onPressed: (){
                      Navigator.of(context).pushNamed('/phoneAuth');
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
