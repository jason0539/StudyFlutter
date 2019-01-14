import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/douban/doubanresponse.dart';
import 'package:flutter_app/douban/movie.dart';
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

  void fetchDouban(bool isFirstPage) async {
    if (isFirstPage) {
      setState(() {
        _movies = [];
      });
      print("第一页");
      _movies.clear();
      currPage = 0;
    } else {
      currPage++;
      print("下一页");
    }
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });
      int start = currPage * pageLimit;
      final response = await http.get(
          "https://api.douban.com/v2/movie/in_theaters?start=${start}&count=${pageLimit}");
      Map<String, dynamic> responseMap = json.decode(response.body);
      print(responseMap);
      if (responseMap.containsKey('code') && responseMap['code'] != 200) {
        String msg = responseMap['msg'];
        print(msg);
      } else {
        DoubanResponse doubanResponse = DoubanResponse.fromJson(responseMap);
        List<DMovie> movies = doubanResponse.movies;
        total = doubanResponse.total;

        if (movies.length == 0) {
          double edge = 50.0;
          double offsetFromBottom = _scrollController.position.maxScrollExtent -
              _scrollController.position.pixels;
          if (offsetFromBottom < edge) {
            _scrollController.animateTo(
                _scrollController.offset - (edge - offsetFromBottom),
                duration: new Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        }

        setState(() {
          _movies.addAll(doubanResponse.movies);
          isPerformingRequest = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchDouban(false);
      }
    });

    fetchDouban(true);
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
              return new Divider(
                indent: 10,
                color: Colors.grey,
                height: 1,
              );
            }
            final index = i ~/ 2;
            if (index == _movies.length) {
              bool end = total == _movies.length;
              return _buildProgressIndicator(end);
            } else {
              return GestureDetector(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Image.network(
                        _movies[index].images.small,
                        height: 200,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                      new Container(
                        width: 250,
                        padding: EdgeInsets.only(left: 10,right: 3),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              _movies[index].title,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            new Container(
                              padding: EdgeInsets.only(top: 10),
                              child: new Text(
                                _movies[index].year,
                                style: new TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) =>
                        new Movie(int.tryParse(_movies[index].id)))),
              );
            }
          },
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: (_movies.length == 0) ? 0 : _movies.length * 2 + 1,
          controller: _scrollController,
        ),
        onRefresh: () {
          fetchDouban(true);
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
    if (isend) {
      body = end;
    } else {
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
