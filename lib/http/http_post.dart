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
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  String hasilResponse = "Belum Ada Data";
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP POST"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text("Name"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text("Job"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              var myresponse = await http.post(
                  Uri.parse("https://reqres.in/api/users"),
                  body: {"name": nameC.text, "job": jobC.text});

              Map<String, dynamic> data =
                  jsonDecode(myresponse.body) as Map<String, dynamic>;

              setState(() {
                hasilResponse = " ${data['name']} - ${data['job']} ";
              });
            },
            child: Text("SUBMIT"),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),
          Text(hasilResponse)
        ],
      ),
    );
  }
}
