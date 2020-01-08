import 'package:bloc_ex5/src/bloc/authorization_bloc.dart';

class HomeBloc {
  logoutUser() {
    authBloc.closeSession();
  }
}
