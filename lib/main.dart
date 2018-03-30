import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  String _url = "https://dog.ceo/api/breeds/list";
  List _items = new List();

  Future<String> getData() async {
    Map data = new Map();

    var response = await http.get(
        Uri.encodeFull(_url),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = JSON.decode(response.body);
    });

    // Create View Models
      for (var item in data["message"]) {
        print(item);
        _items.add(item);
    }

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Puppygram"),
      ),
      body: new ListView.builder(
        itemCount: _items == null ? 0 : _items.length,
        itemBuilder: (BuildContext context, int index) {
          String item = _items[index];
          return new ListTile(
            title: new Text(capitalize(item),
                style: Theme.of(context).textTheme.display1
            ),
          );
        },
      ),
    );
  }

  String capitalize(String input) {
    if (input == null || input.length == 0) {
      return "";
    }

    return input[0].toUpperCase() + input.substring(1);
  }
}