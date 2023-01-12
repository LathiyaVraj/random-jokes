import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/model.dart';

class JokesApiHelper {
  JokesApiHelper._();

  String linkApi = "https://api.chucknorris.io/jokes/random";
  static final JokesApiHelper jokes_api_helper = JokesApiHelper._();

  Future<Random_Jokes?> attach_Jokes() async {
    Uri UriApi = Uri.parse(linkApi);
    http.Response res = await http.get(UriApi);
    if (res.statusCode == 200) {
      Map<String, dynamic> JokesData = jsonDecode(res.body);
      Random_Jokes continued = Random_Jokes.fromJson(JokesData);
      return continued;
    }
  }
}
