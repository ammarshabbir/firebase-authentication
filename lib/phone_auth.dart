import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {

  String phoneNo;
  String smsCode;
  String verificationId;

  Future<void>verifyPhone()async{

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (PhoneAuthCredential credential){
      print('verified');

    };

    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException exception){
      print('${exception.message})');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifyFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
        timeout: Duration(seconds: 60),
    );
  }

  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value){
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              new FlatButton(
                  onPressed: (){
                    final currentUser =   FirebaseAuth.instance.currentUser;
                    if(currentUser != null){
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/homePage');
                    }
                    else{
                      Navigator.pop(context);
                      signIn();
                    }
                  },
                  child: Text('Done'),
              ),
            ],
          );
        }
    );
  }
  signIn(){
    FirebaseAuth.instance.signInWithPhoneNumber(
        phoneNo
    ).then((value) {
          Navigator.of(context).pushReplacementNamed('/homePage');
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                ),
                onChanged: (value){
                  setState(() {
                    phoneNo = value;
                  });
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                  onPressed:verifyPhone,
                child: Text('Verify'),
                textColor: Colors.white,
                elevation: 7.0,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
