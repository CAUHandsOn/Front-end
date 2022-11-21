import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/classroom_provider.dart';

class ClassroomInfo extends StatefulWidget {
  const ClassroomInfo({Key? key, this.classroomID}) : super(key: key);
  final classroomID;

  @override
  State<ClassroomInfo> createState() => _ClassroomInfoState();
}

class _ClassroomInfoState extends State<ClassroomInfo> {

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
          ),
        ],
      ),
    );
  }

  Widget _body(String classroomID){
    return Consumer<ClassroomProvider>(
      builder: (context, provider, widget) {
        provider.getClassroomInfo(classroomID);
        return Padding(
          padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
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
                            '현재 강의실 : ${provider.buildingName}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
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
                    _headCountWidget(provider.memberList.length),
                    const SizedBox(height: 40,),
                    _totalCountWidget(50),
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 10,left: 14),
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
                    provider.memberList.isEmpty
                        ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child : Text("현재 강의실에 참석한 학생이 없습니다", style:
                            TextStyle(fontSize: 20,
                            color: Colors.black),
                           ),),
                        )
                        :ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: provider.memberList.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.id,
                                      style: const TextStyle(
                                          fontSize: 16
                                      )),
                                  Text(item.name,
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //headCount값 가져올 수 있게끔 api수정 필요
    return Scaffold(
      appBar: AppBar(
        title: const Text('강의실 정보'),
      ),
      body: _body(widget.classroomID),
    );
  }
}


