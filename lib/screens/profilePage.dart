import 'package:flutter/material.dart';

import '../helper/authenticationFunctions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Gender gender = Gender.Female;
  String? _gender =
      gender ?? "Male"; // Setting up the default value of the gender.

  DateTime? date;

  Future datePicker() async {
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2025));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(60, 155, 237, 1),
              Color.fromRGBO(32, 137, 229, 1),
              Color.fromRGBO(100, 181, 246, 1),
            ])),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  //height: 90,
                  width: 90,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(name![0].toUpperCase(),
                        style:
                            const TextStyle(color: Colors.red, fontSize: 40)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 10, top: 50),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 10, right: 30, left: 30),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                            color: Colors.blue.shade200.withOpacity(0.5),
                            offset: const Offset(0, 3),
                          )
                        ]),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.person_outline),
                                    hintText: name ?? "Name",
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),

                            Row(
                              children: [
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                ),
                                const Text(
                                  "  Gender: ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Radio(
                                    value: "Male",
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value ?? "";
                                      });
                                    }),
                                const Text("Male",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                Radio(
                                    value: "Female",
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value ?? "";
                                      });
                                    }),
                                const Text("Female",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: birthDate ?? "Date of Birth",
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    prefixIcon: const Icon(
                                        Icons.calendar_today_outlined),
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  datePicker();
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),
                            // SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: email1 ?? "Email",
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    prefixIcon:
                                        const Icon(Icons.alternate_email),
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),
                            //SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: phoneNumber ?? "Phone Number",
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    prefixIcon: const Icon(Icons.phone),
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                //textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.unfocus(),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    //color: Colors.grey,
                                    spreadRadius: 3.0,
                                    blurRadius: 5.0,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(0, 3),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("Changed");
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromRGBO(100, 181, 246, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                    ))),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
