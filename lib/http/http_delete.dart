import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myhttp/http/http_get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = "belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP DELETE"),
        actions: [
          IconButton(
              onPressed: () async {
                var response =
                    await http.get(Uri.parse("https://reqres.in/api/users/2"));
                Map<String, dynamic> mybody = json.decode(response.body);
                print(mybody);
                setState(() {
                  data =
                      "Akun : ${mybody["data"]["first_name"]} ${mybody["data"]["first_name"]}";
                });
              },
              icon: Icon(Icons.download))
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(data),
          SizedBox(
            height: 35,
          ),
          ElevatedButton(
              onPressed: () async {
                var response = await http
                    .delete(Uri.parse("https://reqres.in/api/users/2"));
                if (response.statusCode == 204) {
                  setState(() {
                    data = "data berhasil dihapus";
                  });
                }
                print(response.statusCode);
              },
              child: Text("DELETE")),
        ],
      ),
    );
  }
}
