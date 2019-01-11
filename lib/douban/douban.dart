import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/douban/doubanresponse.dart';
import 'package:http/http.dart' as http;

class Douban extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DoubanState();
  }
}

class DoubanState extends State<Douban> {
  DoubanResponse _doubanResponse = null;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  void fetchDouban() async {
    print("fetchDouban");
    final response = await http
        .get("https://api.douban.com/v2/movie/in_theaters?start=0&count=15");
    Map<String, dynamic> responseMap = json.decode(response.body);
    print(responseMap);
    if (responseMap.containsKey('code') && responseMap['code'] != 200) {
      String msg = responseMap['msg'];
      print(msg);
    } else {
      setState(() {
        _doubanResponse = DoubanResponse.fromJson(responseMap);
      });
    }
  }

  void fetchNextPage() async {
    print("fetchNextPage");
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });
      final response = await http
          .get("https://api.douban.com/v2/movie/in_theaters?start=0&count=15");
      Map<String, dynamic> responseMap = json.decode(response.body);
      print(responseMap);
      setState(() {
        _doubanResponse.movies
            .addAll(DoubanResponse.fromJson(responseMap).movies);
        isPerformingRequest = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchNextPage();
      }
    });

    fetchDouban();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loading = new CircularProgressIndicator();
    Widget content = new RefreshIndicator(
        child: new ListView.builder(
          itemBuilder: (context, i) {
            if (i.isOdd) {
              return new Divider();
            }
            final movies = _doubanResponse.movies;
            final index = i ~/ 2;
            if (index == movies.length) {
              return _buildProgressIndicator();
            } else {
              return new Row(
                children: <Widget>[
                  new Image.network(
                    movies[index].images.small,
                    height: 80,
                  ),
                  new Text(movies[index].title)
                ],
              );
            }
          },
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: (_doubanResponse == null)
              ? 0
              : _doubanResponse.movies.length * 2 + 1,
          controller: _scrollController,
        ),
        onRefresh: () {
          fetchDouban();
        });
    Widget body = (_doubanResponse == null) ? loading : content;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DouBan"),
      ),
      body: new Center(
        child: body,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
