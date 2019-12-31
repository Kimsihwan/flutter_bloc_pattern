import 'package:flutter/material.dart';
import 'package:korean_words/korean_words.dart';
import 'package:naming_app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  _RandomListState createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<KoreanWords> _suggestions = <KoreanWords>[];
  final Set<String> _saved = Set<String>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildList(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text('naming app'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SavedList(
                      saved: _saved,
                    )));
          },
        )
      ],
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index.isOdd) {
        return Divider();
      }
      var realIndex = index ~/ 2;
      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateKoreanWords().take(10));
      }
      return _buildRow(_suggestions[realIndex].myeongsa);
    });
  }

  Widget _buildRow(String word) {
    final bool alreadySaved = _saved.contains(word);
    return ListTile(
      title: Text(
        word,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved)
            _saved.remove(word);
          else
            _saved.add(word);
        });
      },
    );
  }
}
