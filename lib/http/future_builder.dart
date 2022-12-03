import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  List<Map<String, dynamic>> allUser = [];

  Future getAlluser() async {
    try {
      var response = await http.get(Uri.parse("https://reqres.in/api/users"));
      List data = (json.decode(response.body) as Map<String, dynamic>)['data'];

      data.forEach((element) {
        allUser.add(element);
      });
    } catch (e) {
      // print jika terjadi error
      print("Terjadi Kesalahan");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Future Builder"),
        ),
        body: FutureBuilder(
            future: getAlluser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("LOADING...."),
                );
              } else {
                return ListView.builder(
                  itemCount: allUser.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(allUser[index]['avatar']),
                    ),
                    title: Text(
                        "${allUser[index]['first_name']} ${allUser[index]['last_name']}       "),
                    subtitle: Text("e${allUser[index]['email']}   "),
                  ),
                );
              }
            }));
  }
}
