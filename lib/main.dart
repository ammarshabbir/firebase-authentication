import 'package:firstore_basic/home_page.dart';
import 'package:firstore_basic/login_page.dart';
import 'package:firstore_basic/phone_auth.dart';
import 'package:firstore_basic/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: <String ,WidgetBuilder>{
        '/landingPage':(BuildContext context)=>MyApp(),
        '/loginPage':(BuildContext context)=>LoginPage(),
        '/signupPage':(BuildContext context)=>SignupPage(),
        '/homePage':(BuildContext context)=>HomePage(),
        '/phoneAuth':(BuildContext context)=>PhoneAuth(),
    },
    );
  }
}



