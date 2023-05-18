import 'package:flutter/material.dart';


class UserLogo extends StatelessWidget {
  final double size;
  final String imgUrl;
  const UserLogo({super.key,required this.size,required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: NetworkImage(imgUrl),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: size/4,
              backgroundColor: Colors.white,
              child: const CircleAvatar(
                backgroundColor: Colors.green,
              ) // change this children 
            )
          )
        ]
      )
    );
  }
}