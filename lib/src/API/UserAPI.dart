import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ui/home.dart';

class UserAPI{

  Future<dynamic> callLoginAPI(Map<String, dynamic> data) async {
    String url = 'https://bho.ottitor.shop/auth/sign-in';

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print('login response body');
      print(body);
      return body['data'];
    } else {
      print(response.statusCode);
      throw Exception("Failed Login");
    }
  }

  callPatchAPI(Map<String, dynamic> data, String originalID) async {
    String url = 'https://bho.ottitor.shop/user/me';

    http.Response response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=UTF-8'
      },
      body: jsonEncode(data),
    );
    print(data['id']);
    print(jsonEncode(data));
    print(response.body);
    print(originalID);
    // if (response.statusCode == 200) {
    //   return;
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('변경이 저장되지 않았습니다')));
    //   throw Exception('Failed to Register');
    // }
  }

  callRegisterAPI(Map<String,dynamic> data) async{
    String url = 'https://bho.ottitor.shop/auth/sign-up';

    http.Response response = await http.post(Uri.parse(url),
        headers: <String,String>{
          'Content-Type' : 'application/json;charset=UTF-8'
        },
        body: jsonEncode(data)
    );
    if (response.statusCode == 200){
      print("callReisterAPI success!");
      return;
    } else{
      throw Exception('Failed to Register');
    }
  }

}