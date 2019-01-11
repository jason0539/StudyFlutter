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
  List<DMovie> _movies = [];
  int currPage = 0;
  int pageLimit = 15;
  int total = 0;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  void fetchDouban() async {
    setState(() {
      _movies = [];
    });
    print("第一页");
    _movies.clear();
    currPage = 0;
    int start = currPage * pageLimit;
    final response = await http
        .get("https://api.douban.com/v2/movie/in_theaters?start=${start}&count=${pageLimit}");
    Map<String, dynamic> responseMap = json.decode(response.body);
    print(responseMap);
    if (responseMap.containsKey('code') && responseMap['code'] != 200) {
      String msg = responseMap['msg'];
      print(msg);
    } else {
      DoubanResponse doubanResponse = DoubanResponse.fromJson(responseMap);
      total = doubanResponse.total;
      setState(() {
        _movies.addAll(doubanResponse.movies);
      });
    }
  }

  void fetchNextPage() async {
    currPage++;
    print("下一页");
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });
      int start = currPage * pageLimit;
      final response = await http
          .get("https://api.douban.com/v2/movie/in_theaters?start=${start}&count=${pageLimit}");
      Map<String, dynamic> responseMap = json.decode(response.body);
      print(responseMap);
      setState(() {
        setState(() {
          _movies.addAll(DoubanResponse.fromJson(responseMap).movies);
        });
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
            final index = i ~/ 2;
            if (index == _movies.length) {
              bool end = total == _movies.length;
              return _buildProgressIndicator(end);
            } else {
              return new Row(
                children: <Widget>[
                  new Image.network(
                    _movies[index].images.small,
                    height: 80,
                  ),
                  new Text(_movies[index].title)
                ],
              );
            }
          },
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: (_movies.length == 0)
              ? 0
              : _movies.length * 2 + 1,
          controller: _scrollController,
        ),
        onRefresh: () {
          fetchDouban();
        });
    Widget body = (_movies.length == 0) ? loading : content;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DouBan"),
      ),
      body: new Center(
        child: body,
      ),
    );
  }

  Widget _buildProgressIndicator(bool isend) {
    Widget progress = new CircularProgressIndicator();
    Widget end = new Text("加载完了~");
    Widget body = null;
    if(isend){
      body = end;
    }else{
      body = progress;
    }
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: body,
        ),
      ),
    );
  }
}
