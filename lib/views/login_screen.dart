import 'package:cryptonew/authenticaiton/bloc/authentication_bloc.dart';

import 'package:cryptonew/crypto/resources/crypto_api_services.dart';
import 'package:cryptonew/views/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              // to check authentication with bloc
              listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  // if authentication is success then go to home screen with bloc
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiRepositoryProvider(
                                providers: [
                                  RepositoryProvider(
                                    create: (context) => CryptoApiServices(),
                                  )
                                ],
                                child: HomeScreen(),
                              )));
                } else if (state is AuthenticationFailiure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              buildWhen: (current, next) {
                if (next is AuthenticationSuccess) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is AuthenticationInitial ||
                    state is AuthenticationFailiure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/c.png',
                          width: 180,
                        ),
                        Text(
                          'CRYPTO',
                          style: TextStyle(fontSize: 40, color: Colors.orange),
                        ),
                        Text(
                          'PANIC',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.white10)),
                            onPressed: () =>
                                // call google authentication with bloc
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(
                              AuthenticationGoogleStarted(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Login with Google',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthenticationLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                    child: Text('Undefined state : ${state.runtimeType}'));
              },
            );
          },
        ),
      ),
    );
  }
}
