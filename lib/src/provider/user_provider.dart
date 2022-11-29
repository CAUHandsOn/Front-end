import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late String _name;
  late String _email;
  late String _id;
  late String _role;
  List<String> originalID = [];

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get role => _role;

  initUser(name, email, id, role) {
    _name = name;
    _email = email;
    _id = id;
    _role = role;
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set role(String value) {
    _role = value;
    notifyListeners();
  }
}
