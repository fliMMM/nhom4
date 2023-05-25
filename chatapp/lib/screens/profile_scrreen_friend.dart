import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreenFriend extends StatefulWidget {
  final user;

  const ProfileScreenFriend({super.key, required this.user});

  @override
  State<ProfileScreenFriend> createState() => _ProfileScreenFriendState();
}

class _ProfileScreenFriendState extends State<ProfileScreenFriend> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          appBar: AppBar(title: Text(widget.user["displayName"])),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .03),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * .1),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.height * .2,
                      height: MediaQuery.of(context).size.height * .2,
                      fit: BoxFit.cover,
                      imageUrl: widget.user["photoUrl"],
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Text(widget.user["email"],
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Phone: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user["phoneNumber"] ?? "",
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
