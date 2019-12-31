import 'package:flutter/material.dart';

class SavedList extends StatefulWidget {
  final Set<String> saved;

  SavedList({@required this.saved});

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
    return ListView.builder(
        itemCount: widget.saved.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          var realIndex = index ~/ 2;
          return _buildRow(widget.saved.toList()[realIndex]);
        });
  }

  Widget _buildRow(String word) {
    return ListTile(
      title: Text(
        word,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        setState(() {
          widget.saved.remove(word);
        });
      },
    );
  }
}
