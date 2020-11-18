import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class InfoPage extends StatelessWidget {
  LocalStorage storage = LocalStorage('login_info');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Transform(
          transform: Matrix4.translationValues(0, -5.0, 0),
          child: AppBar(
            leading: MaterialButton(
              padding: EdgeInsets.all(0),
              child: ImageIcon(
                AssetImage(
                  'assets/cutlery.png',
                ),
              ),
              onPressed: () {},
            ),
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 30.0,
        ),
        child: FutureBuilder(
            future: storage.ready,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(jsonDecode(storage.getItem('info')));
                return Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "로그인 정보",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID: ${jsonDecode(storage.getItem('info'))['id']}",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              "내 선호 재료: ${jsonDecode(storage.getItem('info'))['userFavor']}",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Divider(
                      color: Colors.black54,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      child: Text("로그아웃"),
                      onPressed: () {},
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      child: Text("회원탈퇴"),
                      onPressed: () {},
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      child: Text("비밀번호 변경"),
                      onPressed: () {},
                    )
                  ],
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
