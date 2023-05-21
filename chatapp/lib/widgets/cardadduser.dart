import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/userinfo.dart';

class AddUser extends StatefulWidget {
  final UsersInfo user;
  const AddUser({super.key, required this.user});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.1,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.height * .055,
                    height: MediaQuery.of(context).size.height * .055,
                    imageUrl: widget.user.photoUrl,
                    errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        )),
              )),
          title: Text(widget.user.displayName),
        ),
      ),
    );
    ;
  }
}
