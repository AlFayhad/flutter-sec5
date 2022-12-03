import 'dart:convert';

import 'package:flutter/material.dart';
import '../widget/summary_item.dart';
import 'package:http/http.dart' as http;
import '../models/Summary.dart';

class HomePage extends StatelessWidget {
  late Summary dataSummary;

  Future getSummary() async {
    var response = await http.get(Uri.parse("https://covid19.mathdro.id/api"));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    dataSummary = Summary.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID 19 SUMMARY"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getSummary(),
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("LOADING DATA..."));
            }
            return Column(
              children: [
                SummaryItem(
                    title: "CONFIRMED",
                    value: "${dataSummary.confirmed.value}"),
                SummaryItem(
                    title: "DEATHS", value: "${dataSummary.deaths.value}"),
              ],
            );
          }),
    );
  }
}
