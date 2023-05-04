import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetDataDetailScreen extends StatefulWidget {
  int? value;
  GetDataDetailScreen({Key? key, this.value}) : super(key: key);

  @override
  _GetDetailScreenState createState() => _GetDetailScreenState(value);
}

class _GetDetailScreenState extends State<GetDataDetailScreen> {
  int? value;
  _GetDetailScreenState(int? value);
  Map? data;
  String? uri;

  @override
  void initState() {
    var url = "https://reqres.in/api/users/${value.toString()}";
    _getRefreshData(url);

    print("susu +${value}");
  }

  Future<void> _getRefreshData(url) async {
    getJsonData(context, url);
  }

  Future<void> getJsonData(BuildContext context, url) async {
    setState(() {
      uri = url;
    });
    var response = await http.get(Uri.parse(uri.toString()),
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get data API regres"),
      ),
      body: Container(
          child: data == null
              ? Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "loading ....",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  child: ListTile(
                    leading: Image.network(data!["avatar"]),
                    title: Text(data!["first_name"] + " " + data!["last_name"]),
                    subtitle: Text(data!["email"]),
                  ),
                )),
    );
  }
}
