import 'dart:convert';
import 'package:actividad_7/models/User.dart';
import 'package:http/http.dart' as http;

class UserController {
  Future getUser() async {
    String url = "https://jsonplaceholder.typicode.com/users";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    List<dynamic> listFromApi = jsonDecode(response.body);
    List<User> users = [];

    for (var jsonUser in listFromApi) {
      User user = User.fromJson(jsonUser);
      users.add(user);
    }
    return users;
  }
}
