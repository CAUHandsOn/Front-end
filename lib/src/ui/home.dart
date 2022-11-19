import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handson/src/model/user.dart';
import 'package:handson/src/provider/bottom_navigation_provider.dart';
import 'package:handson/src/provider/classroom_provider.dart';
import 'package:handson/src/provider/user_provider.dart';
import 'package:handson/src/ui/professor_page/professor_home_widget.dart';
import 'package:handson/src/ui/register/register_widget.dart';
import 'package:handson/src/ui/student_page/student_home_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../provider/classroomList_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  String _currentEmail = '';
  String _currentPassword = '';
  bool _isIdSaved = false;
  bool _isAutoLogin = false;
  String role = 'professor';

  Future<dynamic> _callLoginAPI(Map<String, dynamic> data) async {
    String url = 'https://bho.ottitor.shop/member/me';

    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{'Authorization': '20186984'},
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print('login response body');
      print(body);
      return body['data'];
    } else {
      print(response.statusCode);
      throw Exception("Failed Login");
    }
  }

  Widget _loginBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/images/logo.png', width: 328)],
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '사용자 Email을 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                _currentEmail = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '사용자 Password를 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                _currentPassword = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _isIdSaved,
                  onChanged: (value) {
                    setState(() {
                      _isIdSaved = value!;
                    });
                  },
                ),
                const Text('ID저장        '),
                Checkbox(
                  value: _isAutoLogin,
                  onChanged: (value) {
                    setState(() {
                      _isAutoLogin = value!;
                    });
                  },
                ),
                const Text('자동로그인'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    // 로그인 process
                    if (_formKey.currentState!.validate()) {
                      // 사용자 입력값 1차 검증후 로그인 로직 수행
                      _formKey.currentState!.save();
                      // if (login suceess)

                      var data = Map<String, String>();
                      data['email'] = _currentEmail;
                      data['password'] = _currentPassword;

                      try {
                        _callLoginAPI(data).then((response) {
                          User user = User(
                              email: _currentEmail,
                              name: response['name'],
                              password: _currentPassword,
                              role: response['role'],
                              id: response['id']);

                          if (response['role'] == 'student') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MultiProvider(providers: [
                                          ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                UserProvider(),
                                          ),
                                          ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                BottomNavigationProvider(),
                                          ),
                                          ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                ClassroomProvider(),
                                          ),
                                          ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                ClassroomListProvider(),
                                          ),
                                        ], child: StudentWidget(user: user))));
                          }
                          if (response['role'] == 'professor') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiProvider(
                                            providers: [
                                              ChangeNotifierProvider(
                                                create:
                                                    (BuildContext context) =>
                                                        UserProvider(),
                                              ),
                                              ChangeNotifierProvider(
                                                create: (BuildContext
                                                        context) =>
                                                    BottomNavigationProvider(),
                                              ),
                                              ChangeNotifierProvider(
                                                create:
                                                    (BuildContext context) =>
                                                        ClassroomProvider(),
                                              ),
                                              ChangeNotifierProvider(
                                                create: (BuildContext context) =>
                                                    ClassroomListProvider(),
                                              ),
                                            ],
                                            child: ProfessorWidget(
                                              user: user,
                                            ))));
                          }
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text("로그인")),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterWidget()));
                    if (result != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('$result')));
                    }
                  },
                  child: const Text("회원가입")),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('E-ID Bluetooth'),
        ),
        body: _loginBody());
  }
}
