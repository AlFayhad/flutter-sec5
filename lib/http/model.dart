import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:myhttp/models/user.dart';

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
  List<UserModel> allUser = [];

  Future getAlluser() async {
    try {
      var response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
      List data = (json.decode(response.body) as Map<String, dynamic>)['data'];

      data.forEach((element) {
        allUser.add(
          UserModel.fromJson(element),
        );
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
                if (allUser.length == 0) {
                  return Center(
                    child: Text("TIDAK ADA DATA"),
                  );
                }
                return ListView.builder(
                  itemCount: allUser.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(allUser[index].avatar),
                    ),
                    title: Text(
                        "${allUser[index].firstName} ${allUser[index].lastName}"),
                    subtitle: Text("e${allUser[index].email}"),
                  ),
                );
              }
            }));
  }
}
