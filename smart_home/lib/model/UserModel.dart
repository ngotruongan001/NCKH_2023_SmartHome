class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? urlImg;

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.urlImg});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        urlImg: map['urlImg']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'urlImg': urlImg,
    };
  }
}