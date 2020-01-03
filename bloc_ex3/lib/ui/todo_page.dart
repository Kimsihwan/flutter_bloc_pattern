import 'package:bloc_ex3/bloc/todo_provider.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Widget _buildListTile(AsyncSnapshot snapshot, int index) {
    var id = snapshot.data[index].id;
    var title = snapshot.data[index].title;
    bool completed = snapshot.data[index].completed;

    return ListTile(
      leading: Text('$id'),
      title: Text('$title'),
      subtitle: Text(
        'completed ',
        style: TextStyle(color: completed ? Colors.lightBlue : Colors.red),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    TodoProvider.of(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = TodoProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Stream Builder with Bloc'),
            RaisedButton(
              color: Colors.lightBlueAccent[200],
              child: Text(
                'Load Data',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                todoBloc.getTodo();
              },
            ),
            Flexible(
              child: StreamBuilder(
                stream: todoBloc.results,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('No Data');
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) =>
                            _buildListTile(snapshot, index));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
