import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'welcome to flutter',
      home: RandomWords()
    );
  }
}

class RandomWordState extends State<RandomWords> {
  final _suggestions = ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1"];
  final _biggerFont = TextStyle(fontSize: 18);
  final _util = TextUtil();
  final _saved = new Set<String>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String target = Random().nextInt(1000).toString();
//    return Text(target);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to flutter',
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSave)
        ],
      ),
      body: Center(
        child: _buildSuggestions(),
      ),
    );
  }



  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(_util.take());
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(String content) {
    bool alreadySaved = _saved.contains(content);
    return ListTile(
      title: Text(
        content,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(content);
          } else {
            _saved.add(content);
          }
        });
      },
    );
  }

  void _pushSave() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((String content) {
        return new ListTile(
          title: new Text(
            content,
            style: _biggerFont,
          ),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: const Text('saved suggestions'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => RandomWordState();
}

class TextUtil {
  final _random = Random();

  take() {
    final _target = List.filled(10, "fill" + _random.nextInt(100).toString());
    return _target;
  }
}
