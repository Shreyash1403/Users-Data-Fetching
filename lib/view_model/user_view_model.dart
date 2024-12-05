import 'package:flutter/material.dart';
import 'package:profile_info/model/user.dart';
import 'package:profile_info/service/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  List<User> users = [];
  bool isLoading = false;
  int currentPage = 0;

  // Fetch users
  Future<void> fetchUsers() async {
    //if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final fetchedUsers = await _userService.fetchUsers(currentPage);

      users.addAll(fetchedUsers);
      // currentPage++;
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
