import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  late String _name;
  late String _email;
  late String _id;
  late String _role;

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get role => _role;

  initUser(name,email,id,role){
    _name = name;
    _email = email;
    _id = id;
    _role = role;
  }
}