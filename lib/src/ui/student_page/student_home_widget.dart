import 'package:flutter/material.dart';
import 'package:handson/src/model/user.dart';
import 'package:handson/src/provider/user_provider.dart';
import 'package:provider/provider.dart';

class StudentWidget extends StatefulWidget {
  StudentWidget({Key? key,required this.user}) : super(key: key);
  late User user;

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  late UserProvider _userProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userProvider = Provider.of<UserProvider>(context,listen: false);
    _userProvider.initUser(widget.user.name, widget.user.email, widget.user.id, widget.user.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 페이지'),
      ),
      body: Container(
        child: Text('id : ${widget.user.id} name : ${widget.user.name}'),
      ),
    );
  }
}
