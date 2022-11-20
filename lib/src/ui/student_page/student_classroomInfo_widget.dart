import 'package:flutter/material.dart';

class ClassroomInfo extends StatefulWidget {
  const ClassroomInfo({Key? key}) : super(key: key);

  @override
  State<ClassroomInfo> createState() => _ClassroomInfoState();
}

class _ClassroomInfoState extends State<ClassroomInfo> {

  Widget _body(){
    return Center(

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('강의실 출입 내역'),
      ),
      body: _body(),
    );
  }
}


