import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Future<UserCredential> signInWithGoogle() async {
    return await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      Future.microtask(() => Navigator.pushNamed(context, "/home"));
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/images/light_bg.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Center(
          child: FittedBox(
            child: SignInButton(
              Buttons.Google,
              onPressed: () async {
                try {
                  UserCredential user = await signInWithGoogle();
                  if (context.mounted) {
                    Navigator.pushNamed(context, "/home");
                  }
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(content: Text("An error has occurred: please check your connexion or retry later."));
                      }
                      );
                  debugPrint("here");
                }
              },
            ),
          ),
        ),
      )
    );
  }
}
