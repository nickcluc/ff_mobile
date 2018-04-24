import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<OwnersList> getOwnersList() async {
  final response =
      await http.get('localhost:3000/api/v1/owners.json');
  final responseJson = json.decode(response.body);
  final items = OwnersList.parseJson(responseJson["owners"]);
  return items;
}

class OwnersList {
  final List<Owner> items;

  OwnersList(this.items);

  static OwnersList parseJson(Object jsonObject) {

    if (jsonObject is! List) {
      throw new ArgumentError("Unexpected protocol. JsonArray expected.");
    }

    // ignore: strong_mode_uses_dynamic_as_bottom
    final itemList = (jsonObject as List).map<Owner>((Object jsonEntry) {
      return new Owner(jsonEntry);
    }).toList();

    return new OwnersList(itemList);
  }
}

class Owner {
  String fullName;
  int careerWins;
  int careerLosses;

  Owner(Map<String, dynamic> jsonObject) {
    this.fullName     = jsonObject["full_name"];
    this.careerWins   = jsonObject["career_wins"];
    this.careerLosses = jsonObject["career_losses"];
  }
}

void main() => runApp(new ff_mobile());

class ff_mobile extends StatelessWidget {
  // This widget is the root of your application.
  @override Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainScreen()
    );
  }
}

class MainScreen extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MainScreen> {
  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My App"),
      ),
      body: new FutureBuilder<OwnersList>(
        future: getOwnersList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data.items.length == 0) {
                return new MainEmptyView();
              }
              return new OwnersListView(data.items);
            } else if (snapshot.hasError) {
              print("**************");
              print(snapshot.error);
              print(context);
              print("**************");
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => new MainErrorView(snapshot.error)
              );
            }

            return new MainLoadingView();
          }
      ),
    );
  }
}

class OwnersListView extends StatelessWidget {
  final List<Owner> _items;

  const OwnersListView(this._items);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) => new OwnersListItemView(_items[index]),
      itemCount: _items.length
    );
  }
}

class OwnersListItemView extends StatelessWidget {
  // static const _IMAGE_DIMEN_WIDTH  = 64.0;
  // static const _IMAGE_DIMEN_HEIGHT = 64.0;

  final Owner _item;

  OwnersListItemView(this._item);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(_item.fullName),
      subtitle: new Text("${_item.careerWins} - ${_item.careerLosses}")
    );
    new GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "myRoute");
      },
      child: new Text(_item.fullName),
    );
  }
}

class MainEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Center(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            new Text("Empty")
          ]));
}

class MainErrorView extends StatelessWidget {
  final Error _error;

  MainErrorView(this._error);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("Error"),
      // content: new Text("S.msg_error_while_loading.text([_error])"),
      content: new Text("See log"),
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ]
    );
  }
}

class MainLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Center(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            new CircularProgressIndicator(),
            new Padding(padding: const EdgeInsets.all(8.0)),
            new Text("Please wait while loading…")
          ]));
}
