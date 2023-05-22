import 'package:chatapp/screens/profile_scrreen_friend.dart';
import 'package:flutter/material.dart';
import 'logo.dart';

class MessBar extends StatelessWidget {
  var peerInfo;
  MessBar({super.key, required this.peerInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProfileScreenFriend(user: peerInfo)));
      },
      child: Row(
        children: [
          UserLogo(
              size: 20,
              imgUrl: peerInfo["photoUrl"] ??
                  "https://t4.ftcdn.net/jpg/00/97/58/97/360_F_97589769_t45CqXyzjz0KXwoBZT9PRaWGHRk5hQqQ.jpg"),
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  peerInfo["displayName"] ?? peerInfo["email"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  "Đang hoạt động",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
