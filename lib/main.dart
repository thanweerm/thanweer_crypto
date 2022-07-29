import 'package:cryptonew/crypto/resources/crypto_api_services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authenticaiton/bloc/authentication_bloc.dart';
import 'authenticaiton/data/providers/authentication_firebase_provider.dart';
import 'authenticaiton/data/providers/google_sign_in_provider.dart';
import 'authenticaiton/data/repositories/authenticaiton_repository.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // authentication with bloc
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: AuthenticationRepository(
          authenticationFirebaseProvider: AuthenticationFirebaseProvider(
            firebaseAuth: FirebaseAuth.instance,
          ),
          googleSignInProvider: GoogleSignInProvider(
            googleSignIn: GoogleSignIn(),
          ),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black),
        home: MultiRepositoryProvider(providers: [
          RepositoryProvider(
            create: (context) => CryptoApiServices(),
          ),
        ], child: HomeScreen()),
      ),
    );
  }
}
