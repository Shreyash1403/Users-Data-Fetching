import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profile_info/model/user.dart';

class UserService {
  final String appId = "666a92cbe42133bf4cdb3081";

  Future<List<User>> fetchUsers(int page) async {
    final url =
        Uri.parse('https://dummyapi.io/data/v1/user?limit=10&page=$page');

    http.Response response = await http.get(url, headers: {'app-Id': appId});

    if (response.statusCode == 200) {
      final Map<String, dynamic> mapData = json.decode(response.body);

      final List<dynamic> data = mapData['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
