import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_home/model/UserProfileModel.dart';
import 'package:smart_home/model/bottom_bar.dart';
import 'package:smart_home/screens/Widget/Profile/user_image.dart';

class CreateProflieScreen extends StatefulWidget {
  const CreateProflieScreen({Key? key}) : super(key: key);

  @override
  _CreateProflieScreenState createState() => _CreateProflieScreenState();
}

class _CreateProflieScreenState extends State<CreateProflieScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final fullNameEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final cmndEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //first name field
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Tên không được bỏ trống!");
          }
          if (!regex.hasMatch(value)) {
            return ("Nhập tên hợp lệ(Tối thiểu 3 kí tự)!");
          }
          return null;
        },
        onSaved: (value) {
          fullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            errorMaxLines: 3,
            labelText: "Họ tên",
            labelStyle: TextStyle(color: Colors.black, fontSize: 15)));

    //second name field
    final dateField = TextFormField(
        autofocus: false,
        controller: dateEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Họ không được bỏ trống!");
          }
          return null;
        },
        onSaved: (value) {
          dateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.black,
            ),
            labelText: "Ngày Sinh",
            labelStyle: TextStyle(color: Colors.black, fontSize: 15)));

    //email field
    final phoneField = TextFormField(
      autofocus: false,
      controller: phoneEditingController,
      // keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Vui lòng nhập số điện thoại của bạn!");
        }
        // reg expression for email validation
        if (!RegExp(r'^.{3,}$').hasMatch(value)) {
          return ("Vui lòng nhập đúng số điện thoại!");
        }
        return null;
      },
      onSaved: (value) {
        phoneEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.phone_android_outlined,
            color: Colors.black,
          ),
          errorMaxLines: 3,
          labelText: "Số điện thoại",
          labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
    );

    //password field
    final cmndField = TextFormField(
        autofocus: false,
        controller: cmndEditingController,
        obscureText: false,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Mật khẩu bắt buộc để đăng nhập");
          }
          if (!regex.hasMatch(value)) {
            return ("Nhập mật khẩu hợp lệ(Tối thiểu 6 kí tự)");
          }
        },
        onSaved: (value) {
          cmndEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            errorMaxLines: 3,
            labelText: "Số hộ chiếu CMND/CCCD*",
            labelStyle: TextStyle(color: Colors.black, fontSize: 15)));

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      // keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Vui lòng nhập email của bạn!");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Vui lòng nhập đúng email!");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.email_outlined,
            color: Colors.black,
          ),
          errorMaxLines: 3,
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
    );

    final addressField = TextFormField(
      autofocus: false,
      controller: addressEditingController,
      obscureText: false,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Mật khẩu bắt buộc để đăng nhập");
        }
        if (!regex.hasMatch(value)) {
          return ("Nhập mật khẩu hợp lệ(Tối thiểu 6 kí tự)");
        }
      },
      onSaved: (value) {
        cmndEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.add_location,
            color: Colors.black,
          ),
          errorMaxLines: 3,
          labelText: "Địa chỉ",
          labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
    );

    final createButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepOrange,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              postDetailsToFirestore();
            }
          },
          child: const Text(
            "Xác nhận thông tin",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xEAF88325),
                    Color(0xFFE87114),
                  ],
                  begin: FractionalOffset(0.0, 1.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  // tileMode: TileMode.clamp
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    child: const Center(
                      child: Text(
                        "Cập Nhật Thông Tin",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(

                    height: 800,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: Container(

                      child: SingleChildScrollView(
                        child: Container(
                          height: 900,
                          child: Padding(
                            padding: const EdgeInsets.all(36.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  UserImage(onFileChanged: (String imageUrl) {  },),
                                  const SizedBox(height: 35),
                                  fullNameField,
                                  const SizedBox(height: 20),
                                  dateField,
                                  const SizedBox(height: 20),
                                  phoneField,
                                  const SizedBox(height: 20),
                                  cmndField,
                                  const SizedBox(height: 20),
                                  emailField,
                                  const SizedBox(height: 20),
                                  addressField,
                                  const SizedBox(height: 20),
                                  createButton,
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserProfileModel userProfileModel = UserProfileModel();

    // writing all the values
    userProfileModel.email = user!.email;
    userProfileModel.uid = user.uid;
    userProfileModel.fullName = fullNameEditingController.text;
    userProfileModel.date = dateEditingController.text;
    userProfileModel.phone = phoneEditingController.text;
    userProfileModel.cmnd = cmndEditingController.text;
    userProfileModel.email = emailEditingController.text;
    userProfileModel.address = addressEditingController.text;

    await firebaseFirestore
        .collection("profileUsers")
        .doc(user.uid)
        .update(userProfileModel.toMap());
    Fluttertoast.showToast(msg: "Cập Nhật Thành Công :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) =>  BottomBar()),
            (route) => false);
  }
}