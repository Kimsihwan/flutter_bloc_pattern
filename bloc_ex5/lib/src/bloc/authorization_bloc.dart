import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationBloc {
  String _tokenString = "";
  final PublishSubject _isSessionValid = PublishSubject<bool>();

  get isSessionValid => _isSessionValid.stream;

  void dispose() {
    _isSessionValid.close();
  }

  // 사용자가 종료 된 상태에서 앱을 열 때 사용자 세션을 복원
  void restoreSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = prefs.getString('token');
    if (_tokenString != null && _tokenString.length > 0) {
      _isSessionValid.sink.add(true);
    } else {
      _isSessionValid.sink.add(false);
    }
  }

  // 사용가자 로그인 할 대 사용자 세션을 여는 역할
  void openSession(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _tokenString = token;
    _isSessionValid.sink.add(true);
  }

  // 사용자가 애플리케이션에서 로그아웃하려는 경우 사용자 세션을 닫는다.
  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _isSessionValid.sink.add(false);
  }
}

final authBloc = AuthorizationBloc();
