import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/douban/doubanresponse.dart';
import 'package:flutter_app/douban/movieresponse.dart';
import 'package:http/http.dart' as http;

Future<MovieResponse> fetchMovie(int id) async {
  final response =
      await http.get("https://api.douban.com/v2/movie/subject/${id}");
  Map<String, dynamic> responseMap = json.decode(response.body);
  return MovieResponse.fromJson(responseMap);
}

class Movie extends StatelessWidget {
  final int id;

  Movie(this.id);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Movie"),
      ),
      body: new Center(
        child: new FutureBuilder<MovieResponse>(
            future: fetchMovie(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MovieResponse movieRes = snapshot.data;
                return new ListView(
                  children: <Widget>[new Text(movieRes.summary)],
                );
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              } else {
                return new CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
