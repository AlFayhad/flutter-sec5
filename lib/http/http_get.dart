import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late String body;
  late String id;
  late String email;
  late String name;
  @override
  void initState() {
    // TODO: implement initState
    body = "Belum ada data";
    id = "";
    email = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID : ${id}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "E-mail : ${email}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Name : ${name}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
                onPressed: () async {
                  var myresponse = await myhttp
                      .get(Uri.parse("https://reqres.in/api/users/5"));
                  if (myresponse.statusCode == 200) {
                    print("BERHASIL GET DATA");
                    Map<String, dynamic> data =
                        jsonDecode(myresponse.body) as Map<String, dynamic>;

                    setState(() {
                      id = "${data["data"]["id"]}";
                      email = "${data["data"]["email"]}";
                      name = "${data["data"]["first_name"]}";
                    });
                  } else {
                    print("Error ${myresponse.statusCode}");
                  }
                },
                child: Text("GET DATA"))
          ],
        ),
      ),
    );
  }
}
