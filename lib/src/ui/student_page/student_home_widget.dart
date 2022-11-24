import 'package:flutter/material.dart';
import 'package:handson/src/model/user.dart';
import 'package:handson/src/provider/bottom_navigation_provider.dart';
import 'package:handson/src/provider/button_provider.dart';
import 'package:handson/src/provider/user_provider.dart';
import 'package:handson/src/ui/student_page/student_classroom_widget.dart';
import 'package:handson/src/ui/student_page/student_mypage_widget.dart';
import 'package:handson/src/ui/student_page/student_realtime_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/classroomList_provider.dart';
import '../../provider/classroom_provider.dart';

class StudentWidget extends StatefulWidget {
  StudentWidget({Key? key,required this.user}) : super(key: key);
  late User user;

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  late UserProvider _userProvider;
  late BottomNavigationProvider _bottomNavigationProvider;
  late ClassroomProvider _classroomProvider;
  late ButtonProvider _buttonProvider;

  Widget _bottomNavigationBarWidget(){
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '실시간 인원',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '강의실'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지'
        ),
      ],
      onTap: (index){
        _bottomNavigationProvider.updateIndex(index);
        if (_buttonProvider.currentEditButton == 1){
          _buttonProvider.updateEditButton(0);
        }
      },
      currentIndex: _bottomNavigationProvider.currentNavigationIndex,
    );
  }
  Widget _navigationBodyWidget(){
    switch(_bottomNavigationProvider.currentNavigationIndex){
      case 0:
        return const StudentRealtimeWidget();
      case 1:
        return const StudentClassroomWidget();
      case 2:
        return const StudentMyPageWidget();
      default:
        return Container();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userProvider = Provider.of<UserProvider>(context,listen: false);
    _userProvider.initUser(widget.user.name, widget.user.email, widget.user.id, widget.user.role);
    _classroomProvider = Provider.of<ClassroomProvider>(context,listen: false);
    _classroomProvider.loadStudentClassroomInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    print("build: StudentHomeWidget");
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    _buttonProvider = Provider.of<ButtonProvider>(context);
    return Scaffold(
      body: _navigationBodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
