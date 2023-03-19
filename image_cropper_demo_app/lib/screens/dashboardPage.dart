import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_demo_app/screens/galleryPage.dart';
import 'package:image_cropper_demo_app/screens/loginPage.dart';
import 'package:image_cropper_demo_app/screens/profilePage.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      // final tempImage = File(photo.path);
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
      CroppedFile? croppedImg = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          // maxHeight: 140,
          // maxWidth: 240,

          compressQuality: 100);

      if (croppedImg == null) {
        return null;
      } else {
        return File(croppedImg.path);
      }
    } catch (e) {
      print(e);
      // return ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("assets/successiveLogo.png",
                height: 150, width: 150),
          ),
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
                          //openPopUp = true;
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

                    Text(name == null ? "Default" : name ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(email1 == null ? "Email not found" : email1 ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ],
                ),
              ),

              // Buttons

              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  },
                  child: Row(children: const [
                    // Profile

                    Icon(
                      Icons.people_outline,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_right, color: Colors.black),
                  ])),

              //Change Password
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_right, color: Colors.black),
                    ],
                  )),

              // Gallery

              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GalleryPage()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.image_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_right, color: Colors.black),
                    ],
                  )),

              // Settings

              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_right, color: Colors.black),
                    ],
                  )),

              const Spacer(),

              // Sign Out
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_right, color: Colors.black),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget image_source_container(bool isCamera) {
    return InkWell(
      onTap: () async {
        File? tempImage;
        if (isCamera) {
          tempImage = await pickImage(ImageSource.camera);
          setState(() {
            pickedImage = tempImage;
          });
        } else {
          tempImage = await pickImage(ImageSource.gallery);
          setState(() {
            pickedImage = tempImage;
          });
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isCamera == true ? Icons.camera : Icons.image,
          color: Colors.white,
        ),
      ),
    );
  }
}
