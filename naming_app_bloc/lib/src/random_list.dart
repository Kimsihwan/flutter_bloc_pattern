import 'package:flutter/material.dart';
import 'package:korean_words/korean_words.dart';
import 'package:naming_app/src/bloc/Bloc.dart';
import 'package:naming_app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  _RandomListState createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<KoreanWords> _suggestions = <KoreanWords>[];

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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SavedList()));
          },
        )
      ],
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<String>>(
        stream: bloc.savedListStream,
        builder: (context, snapshot) {
          return ListView.builder(itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider();
            }
            var realIndex = index ~/ 2;
            if (realIndex >= _suggestions.length) {
              _suggestions.addAll(generateKoreanWords().take(10));
            }
            return _buildRow(snapshot.data, _suggestions[realIndex].myeongsa);
          });
        });
  }

  Widget _buildRow(Set<String> saved, String word) {
    final bool alreadySaved = saved == null ? false : saved.contains(word);
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
        bloc.addToOrRemoveFromSavedList(word);
      },
    );
  }
}
