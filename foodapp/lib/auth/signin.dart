import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:foodapp/screens/home/homescreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../product_providers/user_provider.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  late UserProvider userProvider;
  late  User user;

  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential authResult =
      await _auth.signInWithCredential(credential);

      user = authResult.user!;

      if (user != null) {
        userProvider.addUserData(
          currentUser: user,
          userName: user!.displayName ?? "",
          userImage: user!.photoURL ?? "",
          userEmail: user!.email ?? "",
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Handle the case where user is null
        print("User is null");
      }
    } catch (e) {
      // Handle the exception, log, or perform any necessary error handling
      print("Error signing in: $e");
    }
  }



  @override
  Widget build(BuildContext context) {

    userProvider= Provider.of(context);

    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Sign in to Continue'),
              Text(
                'Vegi',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.green.shade500,
                      offset: Offset(3,3),
                    )
                  ]
                )
              ),
              SignInButton(
                Buttons.Apple,
                text: 'Sign in with Apple',
                onPressed: () {},
              ),


              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {
                  _googleSignUp().then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  });
                },
              ),
              Text('By signing in you are going to our'),
              Text('Terms and Privacy Plicy'),
            ],
          ),
        ),
      ),
    );
  }
}
