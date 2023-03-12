import 'dart:io';
import 'package:smart_home/model/UserModel.dart';
import 'package:smart_home/model/UserProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:smart_home/screens/Widget/Profile/round_image.dart';

class UserImage extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;

  UserImage({
    required this.onFileChanged,
  });

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  final imageEditingController = TextEditingController();
  String? urlImg;
  final urlEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl == null)
          Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(width:3,color: Colors.red),
                  borderRadius: const BorderRadius.all(Radius.circular(100))
              ),
              child: Icon(Icons.image,
                  size: 60, color: Theme.of(context).primaryColor)),
        if (imageUrl != null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: AppRoundImage.url(
              imageUrl!,
              width: 110,
              height: 110,
            ),
          ),
        InkWell(
          onTap: () => _selectPhoto(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              imageUrl != null ? 'Thay đổi ảnh' : 'Chọn ảnh',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  }),
              ListTile(
                  leading: const Icon(Icons.filter),
                  title: const Text('Pick a file'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  }),
            ],
          ),
          onClosing: () {},
        ));
  }

  Future _pickImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 40);

    if (pickedFile == null) {
      return;
    }
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    file = await compressImagePath(file.path, 40);

    await _uploadFile(file!.path);
  }

  Future compressImagePath(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result;
  }

  Future _uploadFile(String path) async {
    UserProfileModel userProfileModel = UserProfileModel();
    userProfileModel.image = imageEditingController.text;

    UserModel userModel = UserModel();
    userModel.urlImg = urlEditingController.text;

    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child(DateTime.now().toIso8601String() + p.basename(path));

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    userProfileModel.image = fileUrl;
    await FirebaseFirestore.instance.collection("profileUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userProfileModel.toMap1());

    userModel.urlImg = fileUrl;
    await FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userModel.toMap2());

    setState(() {
      imageUrl = fileUrl;
    });

    widget.onFileChanged(fileUrl);
  }


}