import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String dropdownValue = '냉장고 속 재료를 골라주세요.';
  final _formKeyID = GlobalKey<FormState>();
  final _formKeyPWD = GlobalKey<FormState>();

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
            InputField(
              form: _formKeyID,
              hintText: '아이디를 입력해주세요',
            ),
            SizedBox(
              height: 20.0,
            ),
            InputField(
              form: _formKeyPWD,
              hintText: '비밀번호를 입력해주세요',
              isPasswordField: true,
            ),
            SizedBox(
              height: 20.0,
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
            Builder(
              builder: (context) => MaterialButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  if (_formKeyID.currentState.validate() &&
                      _formKeyPWD.currentState.validate()) {
                    Scaffold.of(context)
                        .showSnackBar(
                          SnackBar(
                            duration: Duration(
                              seconds: 2,
                            ),
                            content: Text('회원가입 진행중입니다..'),
                          ),
                        )
                        .closed
                        .then((reason) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                  }
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
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  bool isPasswordField = false;
  final String hintText;
  final GlobalKey<FormState> form;

  InputField({this.isPasswordField, this.hintText, this.form});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.form,
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 50.0,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return '텍스트를 입력해주세요';
            }
            if (value.length < 4) {
              return '4자 이상 입력해주세요';
            }
            return null;
          },
          obscureText: widget.isPasswordField == null ? false : true,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black54,
            )),
          ),
        ),
      ),
    );
  }
}
