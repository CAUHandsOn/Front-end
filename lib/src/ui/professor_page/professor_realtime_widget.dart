import 'package:flutter/material.dart';
import 'package:handson/src/provider/classroom_provider.dart';
import 'package:provider/provider.dart';

import '../../model/classroom.dart';

class ProfessorRealtimeWidget extends StatefulWidget {
  ProfessorRealtimeWidget({Key? key}) : super(key: key);

  @override
  State<ProfessorRealtimeWidget> createState() =>
      _ProfessorRealtimeWidgetState();
}

class _ProfessorRealtimeWidgetState extends State<ProfessorRealtimeWidget> {

  Widget _headCountWidget(int headCount) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "실시간 인원",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '$headCount명',
            style: const TextStyle(fontSize: 30, color: Colors.indigo),
          )
        ],
      ),
    );
  }

  Widget _totalCountWidget(int totalCount) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "수강 정원",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '$totalCount명',
            style: const TextStyle(fontSize: 30, color: Colors.indigo),
          )
        ],
      ),
    );
  }

  Widget _makeListView(Classroom classroom){
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Text(
                    '현재 강의실 : ${classroom.buildingName}-${classroom.roomNumber}'),
                const Divider(),
                Text('현재 시간 : ${DateTime.now()}'),
                _headCountWidget(classroom.studentList.length),
                _totalCountWidget(classroom.totalCount),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("실시간 참석자 명단"),
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                ListView(
                  children: classroom.studentList.map((item) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.id),
                      Text(item.name)
                    ],
                  )).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build : professor_realtime_widget");
    return Scaffold(
      appBar: AppBar(
        title: const Text('실시간 인원'),
      ),
      body: Consumer<ClassroomProvider>(
        builder: (context, provider, widget) {
          try {
            if (provider.classroomInfo.buildingName.isNotEmpty) {
              print("inside consumer");
              return _makeListView(provider.classroomInfo);
            }
            print("outside consumer");
            return const Center(child: CircularProgressIndicator());
          } catch (e){
            print(e);
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      backgroundColor: Colors.grey.withOpacity(0.25),
    );
  }
}
