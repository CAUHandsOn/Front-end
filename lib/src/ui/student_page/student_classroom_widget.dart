import 'package:flutter/material.dart';
import 'package:handson/src/provider/sharedPreference_provider.dart';
import 'package:handson/src/ui/student_page/student_classroomInfo_widget.dart';
import 'package:provider/provider.dart';
import '../../model/classEntity.dart';
import '../../provider/classroomList_provider.dart';

import '../../provider/classroom_provider.dart';
import '../professor_page/professor_classroomInfo_widget.dart';

class StudentClassroomWidget extends StatefulWidget {
  const StudentClassroomWidget({Key? key}) : super(key: key);

  @override
  State<StudentClassroomWidget> createState() => _StudentClassroomWidgetState();
}

class _StudentClassroomWidgetState extends State<StudentClassroomWidget> {
  late ClassroomListProvider _classroomListProvider;
  late ClassroomProvider _classroomProvider;
  late List<ClassEntity> classroomList;

  Widget _listBody(){
    _classroomListProvider.getClassroomList();

    return Consumer<ClassroomListProvider>(
      builder: (context, provider, widget){
        return ListView.separated(
          itemCount: provider.classroomList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(provider.classroomList[index].name, style: const TextStyle(
              color: Colors.black,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () async{
              var pvdSPF = SPFProvider();
              await pvdSPF.loadData('example');

              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  MultiProvider(providers: [
                    ChangeNotifierProvider(
                      create: (BuildContext context) =>
                          ClassroomProvider(),
                    ),
                    ChangeNotifierProvider(
                      create: (BuildContext context) =>
                          ClassroomListProvider(),
                    ),
                    ChangeNotifierProvider(
                      create: (BuildContext context) {
                        return pvdSPF;
                     }
                    ),
                  ], child : StudentClassroomInfo(
                  classroomID : _classroomListProvider.classroomList[index].id,
                  classroomName : _classroomListProvider.classroomList[index].name
              ))));
            },
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1),
        );
      },
    );
  }

  AppBar myAppBar(){
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: Search(_classroomListProvider.classroomListString, _classroomProvider, _classroomListProvider));
          },
          icon: const Icon(Icons.search),
        ),
      ],
      title: const Text('????????? ??????'),
    );
  }

  @override
  Widget build(BuildContext context) {
    _classroomListProvider = Provider.of<ClassroomListProvider>(context,listen: false);
    _classroomProvider = Provider.of<ClassroomProvider>(context,listen: true);
    return Scaffold(
      appBar: myAppBar(),
      body: _listBody(),
    );
  }
}

class Search extends SearchDelegate {
  String selectedResult = "";
  final List<String> searchList;
  final ClassroomProvider thisClassroomProvider;
  final ClassroomListProvider thisClassroomListProvider;
  Search(this.searchList, this.thisClassroomProvider, this.thisClassroomListProvider);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(selectedResult),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    suggestionList.addAll(searchList.where(
          (element) => element.contains(query),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          onTap: () async{
            var pvdSPF = SPFProvider();
            await pvdSPF.loadData('example');

            print('here is id ${thisClassroomListProvider.classroomList[index].id}');
            selectedResult = suggestionList[index];

            Navigator.push(context, MaterialPageRoute(builder: (context) => MultiProvider(providers: [
              ChangeNotifierProvider(
                create: (BuildContext context) =>
                    ClassroomProvider(),
              ),
              ChangeNotifierProvider(
                create: (BuildContext context) =>
                    ClassroomListProvider(),
              ),
              ChangeNotifierProvider(
                  create: (BuildContext context) {
                    return pvdSPF;
                  }
              ),
            ], child : StudentClassroomInfo(
                classroomID : thisClassroomListProvider.classroomList[index].id,
                classroomName : thisClassroomListProvider.classroomList[index].name
            ))));
          },
        );
      },
    );
  }
}