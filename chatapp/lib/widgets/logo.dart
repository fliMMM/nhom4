import 'package:flutter/material.dart';


class UserLogo extends StatelessWidget {
  final double size;
  final String imgUrl;
  const UserLogo({super.key,required this.size,required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size*2,
      width: size*2,
      child: CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(imgUrl),
        child: Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            radius: size/4,
            backgroundColor: Colors.white,
            child: const CircleAvatar(
              backgroundColor: Colors.green,
            ) // change this children 
          )
        )
      )
    );
  }
}