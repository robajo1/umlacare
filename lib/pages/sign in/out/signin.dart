// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_01/pages.dart';

class Signin extends StatefulWidget {
  final void Function() ontap;
  const Signin({super.key, required this.ontap});

  @override
  State<Signin> createState() => _SignupState();
}

class _SignupState extends State<Signin> {
  String? error;
  bool _obscurePassword = true;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void signuserin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          error = "user not found";
        });
      } else {
        setState(() {
          error = "wrong password";
        });
      }
    }
  }

  signinwithgoogle() async {
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    if (guser == null) return; //if he cancells
    final GoogleSignInAuthentication gauth = await guser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: gauth.idToken,
      accessToken: gauth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } on FirebaseAuthException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 32.0),
                Column(
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 64.0,
                      color: Colors.blue,
                    ),
                    Text(
                      'Adhicine',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.green,
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordcontroller,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: error,
                    prefixIcon: Icon(
                      Icons.lock_outline_sharp,
                      color: Colors.green,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color.fromARGB(158, 158, 158, 158),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signuserin,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Sign In'),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR'),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => signinwithgoogle(),
                    icon: Image.asset(
                      'assets/Google-Symbol.png',
                      height: 24.0,
                    ),
                    label: Text('Continue with Google'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to Adhicine? '),
                    TextButton(
                      onPressed: widget.ontap,
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
