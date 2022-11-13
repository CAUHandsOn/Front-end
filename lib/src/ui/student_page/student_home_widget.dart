import 'package:flutter/material.dart';

class StudentWidget extends StatelessWidget {
  const StudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 페이지'),
      ),
    );
  }
}
