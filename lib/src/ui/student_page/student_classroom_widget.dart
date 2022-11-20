import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../model/classEntity.dart';
import '../../model/classroom.dart';
import '../../provider/classroomList_provider.dart';
import 'package:searchfield/searchfield.dart';

class StudentClassroomWidget extends StatefulWidget {
  const StudentClassroomWidget({Key? key}) : super(key: key);

  @override
  State<StudentClassroomWidget> createState() => _StudentClassroomWidgetState();
}

class _StudentClassroomWidgetState extends State<StudentClassroomWidget> {
  late ClassroomListProvider _classroomListProvider;
  late List<ClassEntity> classroomList;

  Widget _listBody(){
    _classroomListProvider.getClassroomList();

    return Consumer<ClassroomListProvider>(
      builder: (context, provider, widget){
        return ListView.builder(
          itemCount: provider.classroomList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              provider.classroomList[index].name,
            ),
          ),
        );

        // return Form(
        //   key: _formKey,
        //   child: SearchField(
        //     //https://pub.dev/packages/searchfield 패키지 사용
        //     suggestions: provider.classroomList
        //         .map((classroomList) => SearchFieldListItem(classroomList.name,
        //         child: Padding(
        //           padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
        //           child: Align(
        //             alignment: Alignment.centerLeft,
        //             child: Text(
        //               classroomList.name,
        //               style: const TextStyle(color: Colors.black),
        //             ),
        //           ),
        //         )))
        //         .toList(),
        //     searchInputDecoration: InputDecoration(
        //       //input box 관련 ui
        //       filled: true,
        //       fillColor: Colors.white,
        //       enabledBorder: OutlineInputBorder(
        //         borderSide: const BorderSide(
        //           color: Colors.grey,
        //           width: 3.0,
        //         ),
        //         borderRadius: BorderRadius.circular(16.0),
        //       ),
        //       disabledBorder: OutlineInputBorder(
        //         borderSide: const BorderSide(
        //           color: Colors.grey,
        //           width: 3.0,
        //         ),
        //         borderRadius: BorderRadius.circular(16.0),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderSide: const BorderSide(
        //           color: Colors.grey,
        //           width: 3.0,
        //         ),
        //         borderRadius: BorderRadius.circular(16.0),
        //       ),
        //       border: const OutlineInputBorder(),
        //     ),
        //     suggestionsDecoration: const BoxDecoration(
        //       //검색창 리스트 목록 관련 ui
        //       borderRadius: BorderRadius.all(Radius.circular(16.0)),
        //       color: Colors.white,
        //     ),
        //     suggestionItemDecoration: const BoxDecoration(//검색창 리스트 개별 아이템 관련 ui
        //
        //     ),
        //     suggestionState: Suggestion.expand,
        //     textInputAction: TextInputAction.done,
        //     onSubmit: (value) {
        //     //
        //     //   provider.classroomList.forEach().if
        //     //   if (provider.classroomList.contains(value) &&
        //     //       value.isNotEmpty) {
        //     //     //validity 검사
        //     //     pvdStore.setCountry(value); //새로 선택된 지역 정보로 text를 갱신
        //     //
        //     //     if (pvdStore.index == -1) {
        //     //       pvdStoreTheme.getTime(pvdStore.country);
        //     //       pvdStoreTheme.country = value;
        //     //     } else {
        //     //       pvdStore.storedThemes[pvdStore.index]
        //     //           .getTime(pvdStore.country);
        //     //       pvdStore.storedThemes[pvdStore.index].country = value;
        //     //     }
        //     //     _searchController.text = '';
        //     //   } else {
        //     //     _searchController.text = '';
        //     //   }
        //     },
        //     hint: '강의실 검색',
        //     hasOverlay: false,
        //     searchStyle: const TextStyle(
        //       fontSize: 18,
        //       color: Colors.black,
        //     ),
        //     maxSuggestionsInViewPort: 5,
        //     itemHeight: 50,
        //     onSuggestionTap: (x) {},
        //   ),
        // );


        // return ListView(
        //   scrollDirection: Axis.vertical,
        //   children: List.generate(
        //       provider.classroomList.length, (i){
        //     return ListTile(
        //       title: Text(provider.classroomList[i].name),
        //       trailing: const Icon(Icons.arrow_forward),
        //       onTap: () {
        //
        //       },
        //     );
        //   }).toList(),
        // );

      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    _classroomListProvider = Provider.of<ClassroomListProvider>(context,listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('강의실 목록'),
      // ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(_classroomListProvider.classroomListString));
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: const Text('강의실 목록'),
      ),
      body: _listBody(),
    );
  }
}

class Search extends SearchDelegate {
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

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
      // In the false case
          (element) => element.contains(query),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? const Icon(Icons.access_time) : const SizedBox(),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}