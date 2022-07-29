import 'package:cryptonew/authenticaiton/bloc/authentication_bloc.dart';

import 'package:cryptonew/views/widgets/crypto_news_widget.dart';
import 'package:cryptonew/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final username = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Row(
          children: [
            Text(
              'CRYPTO ',
              style: TextStyle(color: Colors.orange),
            ),
            Text(
              'PANIC',
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Text('${username?.displayName}'),
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white60,
                ),
                onPressed: () =>
                    BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationExited(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        // authentication check with bloc
        listener: (context, state) {
          if (state is AuthenticationFailiure) {
            // if authentication failed then go to loge in screen
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationStarted());
            return CircularProgressIndicator();
          } else if (state is AuthenticationLoading) {
            return CircularProgressIndicator();
          } else if (state is AuthenticationSuccess) {
            // if authentication Success then load data in cryptonewswidget
            return CryptoNewsWidget();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
