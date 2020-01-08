import 'package:bloc_ex5/src/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(bloc),
            loadingIndicator(bloc)
          ],
        ),
      ),
    );
  }

  // API 호출 대기 시간 동안 로드 UI를 표시합니다.
  Widget loadingIndicator(LoginBloc bloc) => StreamBuilder<bool>(
        stream: bloc.loading,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            print('loadingIndicator: ' + snapshot.data.toString());
          return Container(
            child: (snapshot.hasData && snapshot.data)
                ? CircularProgressIndicator()
                : null,
          );
        },
      );

  // 이메일 입력을 받고, changeEmail 블록과 연결하여 사용자 입력을 확인하고, 이에 따라 UI를 업데이트합니다.
  Widget emailField(LoginBloc bloc) => StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            print('emailField: ' + snapshot.data.toString());
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
                labelText: 'Email address',
                hintText: 'you@email.com',
                errorText: snapshot.error),
          );
        },
      );

  // emailField와 유사하지만 암호 입력 및 유효성 검사 기능이 있음
  Widget passwordField(LoginBloc bloc) => StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            print('passwordField: ' + snapshot.data.toString());
          return TextField(
            obscureText: true,
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                errorText: snapshot.error),
          );
        },
      );

  // 이것은 버튼이 자신의 자격 증명을 사용하여 사용자가 로그인할 수 있도록 하기 위한 것이다.
  // 이 버튼은 이메일 및 암호 텍스트의 유효성을 확인하면 활성화된다.
  // 그러한 이유로, 이 또한 submitValid 블록에 의해 제어됨
  Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            print('submitButton: ' + snapshot.data.toString());
          return RaisedButton(
            onPressed: (!snapshot.hasData) ? null : bloc.submit,
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
          );
        },
      );
}
