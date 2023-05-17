import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late Size mq;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile screen"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              width: mq.width,
              height: mq.height * .05,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .1),
              child: CachedNetworkImage(
                  width: mq.height * .2,
                  height: mq.height * .2,
                  // fit: BoxFit.fill,
                  imageUrl:
                      'https://img.freepik.com/free-icon/user-profile-icon_318-33925.jpg',
                  errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      )),
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(color: Colors.blue, Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'eg: hihih',
                label: Text('name'),
              ),
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(color: Colors.blue, Icons.info),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'duc master',
                label: Text('Gioi thieu'),
              ),
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            // button update
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: Size(mq.width * .5, mq.height * .05)),
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 28,
              ),
              label: Text('Update', style: TextStyle(fontSize: 16)),
            )
          ],
        )),
      ),
    );
  }
}
