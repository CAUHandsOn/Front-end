import 'member.dart';

class RoomMembers{
  String _getIn;
  Member _member;

  String get getIn => _getIn;
  Member get member => _member;

  RoomMembers(
      this._getIn,
      this._member,
      );

  RoomMembers.fromJson(Map<String,dynamic> json):
    _member = Member.fromJson(json['member']),
    _getIn = json['getIn'] as String;
}