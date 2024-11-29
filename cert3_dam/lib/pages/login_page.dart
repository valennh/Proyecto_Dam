import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:u3_firebase/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
        child: FilledButton(
            onPressed: () {
              ingresoGoogle();
            },
            child: Text('Ingrese con su cuenta de Google')),
      ),
    );
  }

  ingresoGoogle() async {
    GoogleSignInAccount? gUsuario = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? gAuth = await gUsuario?.authentication;

    AuthCredential credencial = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);

    await FirebaseAuth.instance.signInWithCredential(credencial);
  }
}
