// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/models/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../models/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _image;
  final userEmail = Auth().getCurrentUSer()?.email;
  final image = Auth().getCurrentUSer()?.photoURL;
  var username = Auth().getCurrentUSer()?.displayName;
  var phone = '0326428199';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile screen"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .05),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // Anh dai dien
            _getImage(),
            SizedBox(
              height: 18,
            ),
            // Email
            _emailInfo(),
            SizedBox(
              height: 18,
            ),
            // field name
            _fieldNameInfo(),
            SizedBox(
              height: 18,
            ),
            // field About
            _fieldAboutInfo(),
            SizedBox(height: 12),
          ],
        )),
      ),
    );
  }

  Widget _getImage() {
    return Stack(
      children: [
        _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * .1),
                child: Image.file(
                  File(_image!),
                  width: MediaQuery.of(context).size.height * .2,
                  height: MediaQuery.of(context).size.height * .2,
                  fit: BoxFit.cover,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * .1),
                child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.height * .2,
                    height: MediaQuery.of(context).size.height * .2,
                    fit: BoxFit.cover,
                    imageUrl: '$image',
                    errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        )),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: MaterialButton(
            elevation: 1,
            onPressed: () {
              _showBottomSheet();
            },
            shape: const CircleBorder(),
            color: Colors.white,
            child: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }

  Widget _emailInfo() {
    return Text(
      '$userEmail',
      style: const TextStyle(color: Colors.black54, fontSize: 16),
    );
  }

  Widget _fieldNameInfo() {
    return TextFormField(
      initialValue: username,
      onChanged: (value) {
        username = Auth().getCurrentUSer()!.updateDisplayName(value) as String?;
      },
      onSaved: (value) => username = value ?? '',
      decoration: InputDecoration(
        prefixIcon: Icon(color: Colors.blue, Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'eg: hihih',
        label: Text('name'),
      ),
    );
  }

  Widget _fieldAboutInfo() {
    return TextFormField(
      initialValue: phone,
      decoration: InputDecoration(
        prefixIcon: Icon(color: Colors.blue, Icons.info),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: '090290122121',
        label: Text('phone'),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .02,
                bottom: MediaQuery.of(context).size.height * .05),
            children: [
              const Text(
                'Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        fixedSize: Size(MediaQuery.of(context).size.width * .3,
                            MediaQuery.of(context).size.height * .15),
                      ),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          Storage.updateProfilePicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.image)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        fixedSize: Size(MediaQuery.of(context).size.width * .3,
                            MediaQuery.of(context).size.height * .15),
                      ),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          Storage.updateProfilePicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.camera)),
                ],
              )
            ],
          );
        });
  }
}
