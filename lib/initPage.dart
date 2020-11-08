import 'package:flutter/material.dart';
import 'package:recipe_app/loginPage.dart';
import 'package:recipe_app/signUpPage.dart';

class InitPage extends StatefulWidget {
  static const id = 'init_page';

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  String dropdownValue = '냉장고 속 재료를 골라주세요.';

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "오늘뭐먹지?",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              width: _width,
              height: 50.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ID를 입력해주세요',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black54,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: _width,
              height: 50.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password를 입력해주세요',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black54,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50.0,
              width: _width,
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                onChanged: (val) {
                  dropdownValue = val;
                  setState(() {
                    print(dropdownValue);
                  });
                },
                items: <String>['냉장고 속 재료를 골라주세요.', '가지', '감자']
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Container(
                width: _width,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    "회원가입",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: _width,
              child: Divider(
                color: Colors.black54,
              ),
            ),
            MaterialButton(
              child: Text("로그인"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
