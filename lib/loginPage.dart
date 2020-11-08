import 'package:flutter/material.dart';
import 'package:recipe_app/mainPage.dart';
import 'package:recipe_app/signUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String dropdownValue = '냉장고 속 재료를 골라주세요.';
  String id, passwd;

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
              "Login",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            InputField(
              hintText: 'ID를 입력해주세요',
              onChange: (val) {
                id = val;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            InputField(
              hintText: '패스워드를 입력해주세요.',
              isPasswdField: true,
              onChange: (val) {
                passwd = val;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                if (id == 'test' && passwd == 'test') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                }
              },
              child: Container(
                width: _width,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    "로그인",
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
              child: Text("회원가입"),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()))
              },
            )
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final Function onChange;
  bool isPasswdField = false;

  InputField({this.hintText, this.onChange, this.isPasswdField});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width - 30;
    return Container(
      width: _width,
      height: 50.0,
      child: TextField(
        onChanged: onChange,
        obscureText: isPasswdField == true ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
