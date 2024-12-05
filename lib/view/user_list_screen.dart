// import 'package:flutter/material.dart';
// import 'package:profile_info/model/user.dart';
// import 'package:profile_info/view/user_detail_screen.dart';
// import 'package:profile_info/view_model/user_view_model.dart';
// import 'package:provider/provider.dart';

// class UserListScreen extends StatelessWidget {
//   const UserListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Users")),
//       body: Consumer<UserViewModel>(
//         builder: (context, userViewModel, child) {
//           if (userViewModel.isLoading && userViewModel.users.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return ListView.builder(
//             itemCount: userViewModel.users.length + 1,
//             itemBuilder: (context, index) {
//               if (index == userViewModel.users.length) {
//                 userViewModel.fetchUsers();
//                 return const Center(child: CircularProgressIndicator());
//               }

//               User user = userViewModel.users[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(user.picture),
//                 ),
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${user.firstName} ${user.lastName}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text('ID: ${user.id}'),
//                     Text('Title: ${user.title}'),
//                   ],
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => UserDetailScreen(user: user),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:profile_info/model/user.dart';
import 'package:profile_info/view/custom_search_delegate.dart';
import 'package:profile_info/view/user_detail_screen.dart';
import 'package:profile_info/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          List<User> filteredUsers = userViewModel.users
              .where((user) => '${user.firstName} ${user.lastName}'
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
              .toList();

          if (userViewModel.isLoading && filteredUsers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: filteredUsers.length + 1,
            itemBuilder: (context, index) {
              if (index == filteredUsers.length) {
                userViewModel.fetchUsers();
                return const Center(child: CircularProgressIndicator());
              }

              User user = filteredUsers[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.picture),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('ID: ${user.id}'),
                    Text('Title: ${user.title}'),
                  ],
                ),
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
        },
      ),
    );
  }
}
