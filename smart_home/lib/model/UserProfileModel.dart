class UserProfileModel {
  String? uid;
  String? fullName;
  String? date;
  String? phone;
  String? cmnd;
  String? email;
  String? address;
  String? image;

  UserProfileModel({this.uid, this.fullName,this.date, this.phone,this.cmnd,this.email, this.address, this.image});

  // receiving data from server
  factory UserProfileModel.fromMap(map) {
    return UserProfileModel(
      uid: map['uid'],
      fullName: map['fullName'],
      date: map['date'],
      phone: map['phone'],
      cmnd: map['cmnd'],
      email: map['email'],
      address: map['address'],
      image: map['image'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'date': date,
      'phone': phone,
      'cmnd': cmnd,
      'email': email,
      'address': address,
      'image': image
    };
  }

  Map<String, dynamic> toMap1() {
    return {
      'image': image
    };
  }
}