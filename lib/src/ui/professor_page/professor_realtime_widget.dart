import 'package:flutter/material.dart';
import 'package:handson/src/provider/classroom_provider.dart';
import 'package:intl/intl.dart';
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
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '$headCount명',
            style: const TextStyle(fontSize: 50, color: Colors.indigo),
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
            style: TextStyle(fontSize: 16),
          ),

          Text(
            '$totalCount명',
            style: const TextStyle(fontSize: 50, color: Colors.indigo),
          )
        ],
      ),
    );
  }

  Widget _makeListView(Classroom classroom){
    return Padding(
      padding: EdgeInsets.only(top: 16,left: 16,right: 16),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 14),
                      child: Text(
                          '현재 강의실 : ${classroom.buildingName}-${classroom.roomNumber}',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('현재 시간 : ${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())}'),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                _headCountWidget(classroom.studentList.length),
                const SizedBox(height: 40,),
                _totalCountWidget(classroom.totalCount),
                const SizedBox(height: 40,),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 14),
                      child: Text(
                        '실시간 참석자 명단',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: classroom.studentList.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.id,
                          style: TextStyle(
                            fontSize: 16
                          )),
                          Text(item.name,
                          style: TextStyle(
                            fontSize: 16
                          ),),
                        ],
                      ),
                    );

                  }).toList(),
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
            print("Professor_realtime_widget Consumer Called");
            if (provider.is_loaded) {
              return _makeListView(provider.classroomInfo);
            }
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
