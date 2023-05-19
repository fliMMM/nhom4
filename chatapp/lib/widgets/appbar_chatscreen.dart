import 'package:flutter/material.dart';
import 'logo.dart';

class MessBar extends StatelessWidget {
  const MessBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const UserLogo(
            size: 20,
            imgUrl:
                "https://t4.ftcdn.net/jpg/00/97/58/97/360_F_97589769_t45CqXyzjz0KXwoBZT9PRaWGHRk5hQqQ.jpg"),
        SizedBox(
            child: Padding(
          padding: EdgeInsets.only(left: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Bui Huy Back",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Dang hoat dong",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
              )
            ],
          ),
        ))
      ],
    );
  }
}
