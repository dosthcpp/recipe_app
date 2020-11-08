import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
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
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "계정",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
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
          ),
        ));
  }
}
