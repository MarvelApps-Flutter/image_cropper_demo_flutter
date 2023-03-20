import 'package:image_cropper_demo_app/helper/personDatabaseHelper.dart';

import '../models/personModel.dart';

Future<bool> checkCredentials(String email, String password) async {
  bool value = true;
  PersonDatabaseHelper person = PersonDatabaseHelper();
  // Initialise the database
  // await person.initializeDatabase();

  // Fetching
  var info = await person.getPerson(email);

  List<Person> listPerson = [];
  for (var element in info) {
    Person personObj = Person.fromMapObject(element);
    listPerson.add(personObj);
  }

  for (var element in listPerson) {
    if (element.password == password && element.email == email) {
      value = true;
    }
  }

  return value;
}

// Get list of persons

String? name;
String? email1;
String? gender;
String? birthDate;
String? phoneNumber;
getList(List<Person> listPerson) async {
  PersonDatabaseHelper person = PersonDatabaseHelper();
  var info = await person.getPerson(email1 ?? "");

  //listPerson = [];
  for (var element in info) {
    Person personObj = Person.fromMapObject(element);
    listPerson.add(personObj);
  }
}

//String name;

Future<List<String>> getInfoList(String email) async {
  PersonDatabaseHelper person = PersonDatabaseHelper();
  var info = await person.getPerson(email);

  List<Person> listPerson = [];
  for (var element in info) {
    Person personObj = Person.fromMapObject(element);
    listPerson.add(personObj);
  }

  List<String> personInfoList = [];

  for (var element in listPerson) {
    name = element.fullName;
    personInfoList.add(name ?? "name");
    email1 = element.email;
    personInfoList.add(email1 ?? "email");
    birthDate = element.birthDate;
    personInfoList.add(birthDate ?? "birthdate");
    gender = element.gender;
    personInfoList.add(gender ?? "gender");
    phoneNumber = element.phoneNumber;
    personInfoList.add(phoneNumber ?? "phone number");
  }

  print(personInfoList);

  return personInfoList;
}

Future<List<String>> getPersonList(String email) async {
  List<String> personList;
  personList = await getInfoList(email);
  return personList;
}
