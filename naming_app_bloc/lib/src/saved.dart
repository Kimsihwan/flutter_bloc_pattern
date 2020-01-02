import 'package:flutter/material.dart';
import 'package:naming_app/src/bloc/Bloc.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _appBar(),
      body: _buildList(),
    ));
  }

  Widget _appBar() {
    return AppBar(
      title: Text('save'),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<String>>(
        stream: bloc.savedListStream,
        builder: (context, snapshot) {
          var saved = Set<String>();
          if (snapshot.hasData)
            saved.addAll(snapshot.data);
          else
            bloc.addCurrentSaved;
          return ListView.builder(
              itemCount: saved.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) return Divider();
                var realIndex = index ~/ 2;
                return _buildRow(snapshot.data.toList()[realIndex]);
              });
        });
  }

  Widget _buildRow(String word) {
    return ListTile(
      title: Text(
        word,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(word);
      },
    );
  }
}
