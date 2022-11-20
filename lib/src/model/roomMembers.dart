import 'member.dart';

class RoomMembers{
  String _getIn;
  List<Member> _member = [];

  String get getIn => _getIn;
  List<Member> get member => _member;

  RoomMembers(
      this._getIn,
      this._member,
      );

  RoomMembers.fromJson(Map<String,dynamic> json):
    _member = (json['member'] as List<dynamic>).map((item) => Member.fromJson(item)).toList(),
    _getIn = json['getIn'] as String;
}