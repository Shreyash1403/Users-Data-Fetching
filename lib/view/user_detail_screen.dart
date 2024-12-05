import 'package:flutter/material.dart';
import 'package:profile_info/model/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${user.firstName} ${user.lastName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.picture),
            ),
            const SizedBox(height: 20),
            Text(
              'ID: ${user.id}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Title: ${user.title}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Name: ${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
