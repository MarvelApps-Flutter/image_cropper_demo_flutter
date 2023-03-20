import 'package:flutter/material.dart';
import 'package:image_cropper_demo_app/screens/loginPage.dart';
import 'package:intl/intl.dart';

import '../helper/personDatabaseHelper.dart';
import '../helper/validationFunctions.dart';
import '../models/personModel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

String gender = "Male";

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime? _birthDate;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 80, bottom: 20),
                  child: Column(children: [
                    Image.asset(
                      "assets/successiveLogo.png",
                      height: 80.0,
                      width: 80.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        prefixIcon: const Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: Icon(Icons.person)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        return validateName(value ?? "");
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: const Padding(
                          padding: EdgeInsetsDirectional.only(start: 10),
                          child: Icon(Icons.email),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        return validateEmail(value ?? "");
                      },

                      // to shift the focus to next textfield or widget.
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        prefixIcon: const Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: Icon(Icons.phone)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        return validatePhoneNumber(value ?? "");
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //controller: dateController,
                      //keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: _birthDate == null
                            ? 'Date Of Birth'
                            : dateFormat.format(_birthDate!).toString(),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2025))
                            .then((date) {
                          setState(() {
                            _birthDate = date;
                          });
                        });
                      },
                      validator: (date) {
                        if (_birthDate == null) {
                          return "Please enter your date of birth.";
                        }
                        int age = (DateTime.now().year - _birthDate!.year);
                        if (age < 13) {
                          return "Your age is below 13, so you can't register.";
                        }
                        return null;
                      },

                      // to shift the focus to next textfield or widget.

                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Create Password",
                        prefixIcon: const Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: Icon(Icons.lock)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        return validatePassword(value ?? "");
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: confirmPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: const Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: Icon(Icons.lock)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required.";
                        }
                        if (value != passController.value.text) {
                          return "Password do not match.";
                        }
                        return null;
                      },
                      onEditingComplete: () => node.unfocus(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 510,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Icon(
                            Icons.person,
                            color: Colors.grey[600],
                          ),
                          Text(
                            " Gender: ",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                          ),
                          Radio(
                              value: "Male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value ?? "";
                                });
                              }),
                          Text("Male",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16)),
                          Radio(
                              value: "Female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value ?? "";
                                });
                              }),
                          Text("Female",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: 510,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            debugPrint("Details are validated!!");
                            debugPrint("Full Name: ${nameController.text}");
                            debugPrint("Email ID: ${emailController.text}");
                            debugPrint(
                                "Date of Birth: ${dateFormat.format(_birthDate!)}");
                            debugPrint("Gender: $gender");

                            print("Phone Number: ${phoneController.text}");
                            debugPrint("Account Created!!!!!!!");

                            // Creating a new variable
                            var personObject = Person(
                                nameController.text.toString(),
                                emailController.text.toString(),
                                phoneController.text,
                                passController.text.toString(),
                                dateFormat.format(_birthDate!).toString(),
                                gender);
                            // Initialising database instance
                            PersonDatabaseHelper person =
                                PersonDatabaseHelper();
                            await person.initializeDatabase();

                            // Inserting the person details
                            await person.insertPerson(personObject);

                            // After insertion user will be navigated to login page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(27, 213, 210, 10)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ))),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    /*SizedBox(
                      height: 5.0,
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ]),
                )),
          ),
        ),
      ),
    );
  }
}
