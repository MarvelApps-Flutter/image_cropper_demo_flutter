import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_demo_app/constants/image_constants.dart';
import 'package:image_cropper_demo_app/constants/string_constants.dart';
import 'package:image_cropper_demo_app/screens/loginPage.dart';
import 'package:image_cropper_demo_app/screens/profilePage.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/authenticationFunctions.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  File? pickedImage;
  bool openPopUp = false;
  Future<File?> pickImage(ImageSource imageType) async {
    File? tempImage;
    try {
      final photo =
          await ImagePicker().pickImage(source: imageType, imageQuality: 100);
      if (photo == null) return null;
      tempImage = File(photo.path);

      tempImage = await _cropImage(imageFile: tempImage);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (error) {
      log(error.toString());
    }
    return tempImage;
  }

  Future<File?> _cropImage({required File imageFile}) async {
    try {
      CroppedFile? croppedImg = await ImageCropper()
          .cropImage(sourcePath: imageFile.path, compressQuality: 100);

      if (croppedImg == null) {
        return null;
      } else {
        return File(croppedImg.path);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.dashboard),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: pickedImage != null
              ? InkWell(
                  onTap: () async {
                    await pickImage(ImageSource.gallery);
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(pickedImage!), fit: BoxFit.cover)),
                  ),
                )
              : Image.asset(ImageConstant.successiveSignupLogo,
                  height: 150, width: 150),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(60, 155, 237, 1),
                    Color.fromRGBO(32, 137, 229, 1),
                    Color.fromRGBO(100, 181, 246, 1),
                  ]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        pickedImage = await pickImage(ImageSource.gallery);
                        setState(() {
                          pickedImage = pickedImage;
                        });
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        //color: Colors.white,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: pickedImage != null
                            ? Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(
                                          pickedImage!,
                                        ),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: Text(name![0].toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 40))),
                      ),
                    ),

                    // printing Name
                    const SizedBox(height: 20),

                    Text(
                        name == null
                            ? StringConstants.defaultLabel
                            : name ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(
                        email1 == null
                            ? StringConstants.emailNotFound
                            : email1 ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ],
                ),
              ),

              // Buttons
              drawerButtonSection(context, ProfilePage(),
                  StringConstants.profile, Icons.people_outline),

              //Change Password
              drawerButtonSection(context, null, StringConstants.changePassword,
                  Icons.lock_outline),
              // Gallery
              drawerButtonSection(
                  context, null, StringConstants.gallery, Icons.image_outlined),
              // Settings
              drawerButtonSection(
                  context, null, StringConstants.settings, Icons.settings),
              const Spacer(),
              // Sign Out
              drawerButtonSection(
                  context, LoginPage(), StringConstants.logOut, Icons.logout),
            ],
          ),
        ),
      ),
    );
  }

  TextButton drawerButtonSection(BuildContext context, Widget? navigatingScreen,
      String buttonLabel, IconData buttonIcon) {
    return TextButton(
        onPressed: () {
          if (navigatingScreen != null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => navigatingScreen));
          }
        },
        child: Row(
          children: [
            Icon(
              buttonIcon,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              buttonLabel,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal),
            ),
            Spacer(),
            Icon(Icons.arrow_right, color: Colors.black),
          ],
        ));
  }
}
