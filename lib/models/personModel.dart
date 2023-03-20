class Person {
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  //String _confirmPassword;
  String? _birthDate;
  String? _gender;

  Person(
    this._fullName,
    this._email,
    this._phoneNumber,
    this._password,
    //this._confirmPassword,
    this._birthDate,
    this._gender,
  );

// Getter
  String get fullName => _fullName ?? "";
  String get email => _email ?? "";
  String get phoneNumber => _phoneNumber ?? "";
  String get password => _password ?? "";
  String get birthDate => _birthDate ?? "";
  String get gender => _gender ?? "";

//Setter
  set fullName(String newName) {
    _fullName = newName;
  }

  set email(String newEmail) {
    _email = newEmail;
  }

  set phoneNumber(String newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
  }

  set password(String newPassword) {
    _password = newPassword;
  }

  set birthDate(String newBirthDate) {
    _birthDate = newBirthDate;
  }

  set gender(String newGender) {
    _gender = newGender;
  }

// Convering person schema into Map.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['fullName'] = _fullName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['password'] = _password;
    map['birthDate'] = _birthDate;
    map['gender'] = _gender;

    return map;
  }

  // Function which will help us extract a person object from a Map object.
  Person.fromMapObject(Map<String, dynamic> map) {
    _fullName = map['fullName'];
    _email = map['email'];
    _phoneNumber = map['phoneNumber'];
    _password = map['password'];
    _birthDate = map['birthDate'];
    _gender = map['gender'];
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  // @override
  // String toString() {
  //   return 'Person {fullName: $fullName, email: $email, phoneNumber: $phoneNumber, password: $password, birthDate: $birthDate, gender: $gender}';
  // }
}
