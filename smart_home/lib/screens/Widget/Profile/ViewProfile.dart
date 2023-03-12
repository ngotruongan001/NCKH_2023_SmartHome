import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/model/UserProfileModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home/screens/Widget/Profile/CreateProfile.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserProfileModel loggedInUser = UserProfileModel();
  // string for displaying the error Message
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("profileUsers")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserProfileModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    var urlImage; urlImage= loggedInUser.image;
    //first name field
    final createButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepOrange,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          minWidth: MediaQuery.of(context).size.width * 0.5,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateProflieScreen()));
          },
          child: const Text(
            "Chỉnh Sửa Thông Tin",
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
              const SizedBox(
                height: 80,
                child: Center(
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
                    child: SizedBox(
                      height: 900,
                      child: Center(
                        child: Padding(
                          padding:  const EdgeInsets.fromLTRB(20,30,10,10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    height: 130,
                                    width: 130,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      clipBehavior: Clip.none,
                                      children: [
                                        if (urlImage == null)
                                          Container(
                                              width: 110,
                                              height: 110,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width:2,color: Colors.red),
                                                  borderRadius: BorderRadius.all(Radius.circular(100))
                                              ),
                                              child: Icon(Icons.image,
                                                  size: 60, color: Theme.of(context).primaryColor)),
                                        if (urlImage != null)
                                          CircleAvatar(
                                              backgroundImage: NetworkImage (
                                                  urlImage)
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10, left: 30),
                                                    child:
                                                        const Text("Họ và tên:",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 20,
                                                            )),
                                                  ),
                                                  if (loggedInUser.fullName ==
                                                      null)
                                                    const Text("Chưa cập nhật...",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18,
                                                        )),
                                                  if (loggedInUser.fullName !=
                                                      null)
                                                    Text(
                                                        "${loggedInUser.fullName} ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10, left: 30),
                                                    child:
                                                        const Text("Ngày sinh:",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 20,
                                                            )),
                                                  ),
                                                  if (loggedInUser.date == null)
                                                    const Text("Chưa cập nhật...",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                  if (loggedInUser.date != null)
                                                    Text("${loggedInUser.date} ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10, left: 30),
                                                    child:
                                                        const Text("Điện thoại:",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 20,
                                                            )),
                                                  ),
                                                  if (loggedInUser.phone == null)
                                                    const Text("Chưa cập nhật...",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                  if (loggedInUser.phone != null)
                                                    Text("${loggedInUser.phone} ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10, left: 30),
                                                    child: const Text("Số CMND:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  if (loggedInUser.cmnd == null)
                                                    const Text("Chưa cập nhật...",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                  if (loggedInUser.cmnd != null)
                                                    Text("${loggedInUser.cmnd} ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10, left: 30),
                                                    child: const Text("Email:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  if (loggedInUser.email == null)
                                                    const Text("Chưa cập nhật...",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                  if (loggedInUser.email != null)
                                                    Text("${loggedInUser.email} ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10, left: 30),
                                                    child: const Text("Địa chỉ:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  if (loggedInUser.address ==
                                                      null)
                                                    const Text("Chưa cập nhật...",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                  if (loggedInUser.address !=
                                                      null)
                                                    Text(
                                                        "${loggedInUser.address} ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 19,
                                                        )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 35),
                                      createButton,
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  )))
            ],
          ),
        ),
      ),
    ));
  }
}
