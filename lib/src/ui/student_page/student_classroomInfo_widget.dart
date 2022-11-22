import 'dart:collection';
import 'dart:js_util';

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
  var _switchValue = false;

  // api로 교체 필요
  // HashMap --> entryList[건물 이름] = List of 출입 기록
  // HashMap을 DB에 load 및 save 할 필요 (새로운 출입 생길 시 update 필요)
  HashMap<String, List<String>> entryLog = HashMap<String, List<String>>();
  List<String> entry = List.empty(growable: true);

  void addList(){
    entry.add('2022-11-21T12:23:24.138883963');
    entry.add('2022-11-22T12:24:24.138883963');
    entry.add('2022-11-23T12:25:24.138883963');
    entry.add('2022-11-24T12:26:24.138883963');
    entry.add('2022-11-25T12:27:24.138883963');

    entryLog['310관 312호'] = entry;
  }


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

  Widget _Info(String classroomID){
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

  Widget _entryLog(){
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
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '현재 강의실 : 310관 B312',
                        style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                      ),
                      Row(
                        children: [
                          const Text(
                            '내역 지우기',
                            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                          ),
                          Switch(
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
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
                      child: Text('현재 시간 : ${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())}',
                      style: TextStyle(color: Colors.black),),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),

                entryLog!['310관 312호']!.isEmpty
                    ? const Padding( //비어 있으면
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child : Text("현재 강의실에 참석한 학생이 없습니다", style:
                          TextStyle(fontSize: 20,
                              color: Colors.black),
                          ),),
                      )
                    : _switchValue //비어 있지 않으며 내역 지우기가 활성화 일 시
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entryLog!['310관 312호']!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(entryLog!['310관 312호']![index]),
                            direction: DismissDirection.startToEnd,//왼쪽에서 오른쪽으로 스와이프
                            onDismissed: (direction){//값을 완전히 삭제
                              setState(() {
                                if(direction== DismissDirection.startToEnd){
                                  entryLog!['310관 312호']!.removeAt(index);
                                }
                              });
                            },
                            child: ListTile(
                              title: Text('${entryLog!['310관 312호']![index]}'),
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1),
                      )
                    : ListView.separated( //비어 있지 않으며 내역 지우기가 비활성화 일 시
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: entryLog!['310관 312호']!.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(entryLog!['310관 312호']![index], style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1),
                        ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //api로 교체 필요
    addList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('강의실'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '정보'),
              Tab(text: '출입 내역'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Tab(
              child : _Info(widget.classroomID),
            ),
            Tab(
              child : _entryLog(),
            ),
          ],
        )
      ),
    );
  }
}


