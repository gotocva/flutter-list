

import 'dart:convert';
import 'package:flutterlist/model/User.dart';
import 'package:http/http.dart' as http;

class ApiCall {

  final String _uri = "http://www.json-generator.com/api/json/get/cfKSgjqZbC?indent=2";

  Future<List<User>> getUsers() async {
      var jsonResponse = await http.get(this._uri);
      var users = json.decode(jsonResponse.body);
      List<User> Users = [];
      for(var user in users){
        User u = new User(user["name"],user["email"],user["image"]);
        Users.add(u);
      }
      print(Users);
      return Users;
  }
}