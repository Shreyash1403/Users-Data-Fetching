import 'package:flutter/material.dart';
import 'package:profile_info/model/user.dart';
import 'package:profile_info/view/user_detail_screen.dart';
import 'package:profile_info/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clears the search input
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Closes the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    List<User> filteredUsers = userViewModel.users
        .where((user) => '${user.firstName} ${user.lastName}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        User user = filteredUsers[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.picture),
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.title),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(user: user),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    List<User> filteredUsers = userViewModel.users
        .where((user) => '${user.firstName} ${user.lastName}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        User user = filteredUsers[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.picture),
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.title),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(user: user),
              ),
            );
          },
        );
      },
    );
  }
}
