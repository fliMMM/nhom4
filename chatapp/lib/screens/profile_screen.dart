// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/models/storage.dart';
import 'package:chatapp/models/store.dart';
import 'package:chatapp/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../models/auth.dart';
import '../models/userinfo.dart';

class ProfileScreen extends StatefulWidget {
  final UsersInfo user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _image;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile screen"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              // Anh dai dien
              _getImage(),
              const SizedBox(
                height: 18,
              ),
              // Email
              _emailInfo(),
              const SizedBox(
                height: 18,
              ),
              // field name
              _fieldNameInfo(),
              const SizedBox(
                height: 18,
              ),
              // field phone
              _fieldPhone(),
              const SizedBox(height: 12),
              _buttonUpdate(),
            ],
          )),
        ),
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
                    imageUrl: widget.user.photoUrl,
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
      '${widget.user.email}',
      style: const TextStyle(color: Colors.black54, fontSize: 16),
    );
  }

  Widget _fieldNameInfo() {
    return TextFormField(
      initialValue: widget.user.displayName,
      onSaved: (value) => Store.me.displayName = value ?? '',
      validator: (value) =>
          value != null && value.isNotEmpty ? null : 'Require Field',
      decoration: InputDecoration(
        prefixIcon: Icon(color: Colors.blue, Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'eg: Kaye',
        label: Text('name'),
      ),
    );
  }

  Widget _fieldPhone() {
    return TextFormField(
      initialValue: widget.user.phoneNumber,
      onSaved: (value) => Store.me.phoneNumber = value ?? '',
      validator: (value) =>
          value != null && value.isNotEmpty ? null : 'Require Field',
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

  Widget _buttonUpdate() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size(MediaQuery.of(context).size.width * .5,
              MediaQuery.of(context).size.height * .05)),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          Store.updateUserInfo().then((value) {
            Dialogs.showSnackbar(context, 'Cập nhật thành công');
          });
        }
      },
      icon: Icon(
        Icons.edit,
        size: 28,
      ),
      label: Text('Update', style: TextStyle(fontSize: 16)),
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
