import 'package:flutter/material.dart';
import 'package:project_01/pages/sign%20in/out/signin.dart';
import 'package:project_01/pages/sign%20in/out/signup.dart';

class Signinorsignup extends StatefulWidget {
  const Signinorsignup({super.key});

  @override
  State<Signinorsignup> createState() => _SigninorsignupState();
}

class _SigninorsignupState extends State<Signinorsignup> {
  bool showsigninpage = true;

  void togglepage() {
    setState(() {
      showsigninpage = !showsigninpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsigninpage) {
      return Signin(ontap: togglepage);
    } else {
      return Signup(ontap: togglepage);
    }
  }
}
