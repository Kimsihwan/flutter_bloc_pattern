import 'package:bloc_ex3/bloc/todo_bloc.dart';
import 'package:bloc_ex3/bloc/todo_provider.dart';
import 'package:flutter/material.dart';

import 'repository/api.dart';
import 'ui/todo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TodoProvider(
      todoBloc: TodoBloc(API()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TodoPage(),
      ),
    );
  }
}
