import 'package:chatapp/models/auth.dart';
import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';

class MyDrawer extends StatelessWidget {
  get image => Auth().getCurrentUSer()?.photoURL;
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Amaru'),
            accountEmail: Text('leduc@gmail.com'),
            // currentAccountPicture: CircleAvatar(
            //   child: ClipOval(

            //     child: Image.network(image),
            //   ),
            // ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
              icon: Icon(Icons.people)),
          ListTile(
            title: const Text('Đoạn chat'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Đăng xuất'),
            onTap: () {
              Auth().signOut();
            },
          ),
        ],
      ),
    );
  }
}
