import 'dart:convert';
import 'package:http/http.dart' as http;

class UserResponse {
  String id;
  String name;
  String email;
  String avatar;

  UserResponse(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatar});

  factory UserResponse.createUserResponse(Map<String, dynamic> object) {
    return UserResponse(
        id: object['id'].toString(),
        name: object['first_name'] + " " + object['last_name'],
        email: object['email'],
        avatar: object['avatar']);
  }

  static Future<List<UserResponse>> getUserList(String page) async {
    var apiUrl = Uri.parse("https://reqres.in/api/users?page=" + page);
    var apiResult = await http.get(apiUrl);

    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

    List<UserResponse> users = [];
    for (int i = 0; i < listUser.length; i++) {
      users.add(UserResponse.createUserResponse(listUser[i]));
    }
    return users;
  }
}
