import 'package:bloc_ex5/src/bloc/authorization_bloc.dart';
import 'package:flutter/material.dart';

import 'ui/home_screen.dart';
import 'ui/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: createContent(),
    );
  }

  createContent() => StreamBuilder<bool>(
      stream: authBloc.isSessionValid,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          print('createContent: ' + snapshot.data.toString());
        if (snapshot.hasData && snapshot.data) {
          return HomeScreen();
        }
        return LoginScreen();
      });
}
