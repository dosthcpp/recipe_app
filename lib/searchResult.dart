import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:recipe_app/recipePage.dart';

class SearchResult extends StatefulWidget {

  List<String> searchParam = [];

  SearchResult({this.searchParam});


  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<List<String>> searchResult = [];

  List<Recipe> recipeListForRender = [];
  ScrollController controller;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final alert = AlertDialog(
        title: Text('App'),
        content: Text('파라미터 값이 없습니다.'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'))
        ],
      );
      if (widget.searchParam.length == 0) {
        showDialog(
          context: context,
          builder: (_) => alert,
        );
      }
    });
  }

  void _scrollListener() {
    // if (controller.position.extentAfter < 500) {
    //   setState(() {
    //     renderAdvanced
    //         .addAll(List.generate(10, (index) => recipeListForRender[index]));
    //   });
    // }
  }

  Future<List<Recipe>> fetchIngredientList() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/recipe.json');
    List<dynamic> recipeDetail = jsonDecode(data);
    List<List<String>> ingredients = [];
    for (int i = 0; i < recipeDetail.length; ++i) {
      List<String> temp = [];
      [
        ...?recipeDetail.map((cur) => cur["ingredients"]).toList()[i]['주재료'],
        ...?recipeDetail.map((cur) => cur["ingredients"]).toList()[i]['부재료'],
        ...?recipeDetail.map((cur) => cur["ingredients"]).toList()[i]['양념']
      ].forEach((element) {
        temp.add(element.keys.toString().replaceAll(RegExp('[()]'), ''));
      });
      temp.sort((a, b) => a.compareTo(b));
      ingredients.add(temp);
    }
    var cnt = 0;
    for (int i = 0; i < ingredients.length; ++i) {
      if (widget.searchParam.every((ing) => ingredients[i].contains(ing))) {
        recipeListForRender.add(Recipe.fromJson(recipeDetail[i]));
        cnt++;
      }
    }
    if(cnt == 0) {
      Future.delayed(Duration.zero, () {
        final alert = AlertDialog(
          title: Text('App'),
          content: Text('검색 결과가 없습니다.'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'))
          ],
        );
        showDialog(
          context: context,
          builder: (_) => alert,
        );
      });
    }
    for (int i = 0; i < recipeListForRender.length; ++i) {
      recipeListForRender[i].recommendation = 0;
      for (int j = 0;
          j < recipeListForRender[i].ingredients["주재료"].length;
          ++j) {
        recipeListForRender[i].recommendation += 100;
      }
      for (int j = 0;
          j < recipeListForRender[i].ingredients["부재료"].length;
          ++j) {
        recipeListForRender[i].recommendation += 50;
      }
      for (int j = 0;
          j < recipeListForRender[i].ingredients["양념"].length;
          ++j) {
        recipeListForRender[i].recommendation += 10;
      }
    }
    recipeListForRender
        .sort((a, b) => b.recommendation.compareTo(a.recommendation));
    return recipeListForRender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Transform(
            transform: Matrix4.translationValues(0, -5.0, 0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 5.0,
              title: Text(
                '오늘뭐먹지?',
                style: TextStyle(color: Colors.black45),
              ),
              actions: <Widget>[
                Transform(
                  transform: Matrix4.translationValues(-10, 0, 0),
                  child: Container(
                    width: 30.0,
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: widget.searchParam.length != 0
            ? FutureBuilder<List<Recipe>>(
                future: fetchIngredientList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: recipeListForRender == null
                            ? 0
                            : recipeListForRender.length,
                        itemBuilder: (context, idx) {
                          return recipeListForRender.length == 0
                              ? SizedBox()
                              : Column(children: [
                                  idx == 0 ? SizedBox() : Divider(),
                                  MaterialButton(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.0,
                                            ),
                                            child: Image(
                                              width: 80,
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImageWithRetry(
                                                recipeListForRender[idx].picture,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      '${recipeListForRender[idx].name}'),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  idx >= 0 && idx < 10
                                                      ? SubTitle(
                                                          title: "추천",
                                                          color: Colors.redAccent,
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.favorite,
                                                    size: 12.0,
                                                  ),
                                                  Text(
                                                      " ${recipeListForRender[idx].recommendation}")
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      var searchParam = [
                                        ...?recipeListForRender[idx].ingredients['주재료'],
                                        ...?recipeListForRender[idx].ingredients['부재료'],
                                        ...?recipeListForRender[idx].ingredients['양념'],
                                      ].map((cur) => Map.from(cur).keys.toString().replaceAll(RegExp('[()]'), '')).toList();
                                      searchParam.sort((a, b) => a.compareTo(b));
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => RecipePage(
                                            ingredientsForSearch: searchParam,
                                          )));
                                    },
                                  ),
                                  idx == recipeListForRender.length
                                      ? Divider()
                                      : SizedBox()
                                ]);
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : SizedBox());
  }
}
