import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/models/auth.dart';
import 'package:chatapp/models/store.dart';
import 'package:flutter/cupertino.dart';
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
            accountName: const Text('Amaru'),
            accountEmail: const Text('leduc@gmail.com'),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: Store.me.photoURL,
                  errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      )),
            ),
            decoration: const BoxDecoration(
              color: Colors.pinkAccent,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://img.freepik.com/free-vector/network-mesh-wire-digital-technology-background_1017-27428.jpg?w=360'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text(
              'Đoạn chat',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                            user: Store.me,
                          )));
            },
          ),
          ListTile(
              leading: const Icon(Icons.share),
              title: const Text(
                'Share',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => print('Share')),
          ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text(
                'Thông báo',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => print('thông báo')),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Đăng xuất',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Auth().signOut();
            },
          ),
        ],
      ),
    );
  }
}
