import 'package:flutter/material.dart';
import 'package:profile_info/view/user_list_screen.dart';
import 'package:profile_info/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserViewModel();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter User List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserListScreen(),
      ),
    );
  }
}
