import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  const MessageEnum(this.type);
  final String type;
}

// Using an extension
// Enhanced enums

extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case 'audio':
        return MessageEnum.audio;
      case 'image':
        return MessageEnum.image;
      case 'text':
        return MessageEnum.text;
      case 'gif':
        return MessageEnum.gif;
      case 'video':
        return MessageEnum.video;
      default:
        return MessageEnum.text;
    }
  }
}

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false, //بدك ترجع الى الي قبل ولا لا
    );

Widget DefailTextFild(
        {required Size size,
        required TextEditingController controller,
        required TextInputType type,
        required String stringError,
        bool isPassword = false,
        var ontap,
        var onS,
        var onchanged,
        required String hintText,
        required IconData prefix,
        IconData? suffix,
        var suffixPressed}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset.fromDirection(0, 0),
            spreadRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onchanged,
        onFieldSubmitted: onS,
        keyboardType: type,
        validator: (value) {
          if (value!.isEmpty) {
            return stringError;
          }
        },
        onTap: ontap,
        obscureText: isPassword,
        cursorColor: Colors.lightGreen,
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              prefix,
              color: Colors.lightGreen,
            ),
            border: InputBorder.none,
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(
                      suffix,
                      color: Colors.lightGreen,
                    ),
                  )
                : null),
      ),
    );

Widget DefaultBotton({
  required Size size,
  required Function function,
  required String text,
}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            function();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.lightGreen,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );

Widget DefaultText(
        {required bool login, required context, required Widget widgetTo}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            navigateTo(context, widgetTo);
          },
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Colors.lightGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// void showToast({
//   required String text,
//   required ToastStates state,
// }) =>
//     Fluttertoast.showToast(
//         msg: text,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         //تظهر على شاشة
//         timeInSecForIosWeb: 1,
//         backgroundColor: ChooseToastColor(state),
//         textColor: Colors.black87,
//         fontSize: 16.0);
//
// enum ToastStates { SUCCESS, ERROR, WARNING }
//
// Color ChooseToastColor(ToastStates state) {
//   Color color;
//   switch (state) {
//     case ToastStates.SUCCESS:
//       color = Colors.green;
//       break;
//     case ToastStates.ERROR:
//       color = Colors.red;
//       break;
//     case ToastStates.WARNING:
//       color = Colors.amber;
//       break;
//   }
//   return color;
// }

Widget defailTextFild(
        {required Size size,
        required TextEditingController controller,
        required TextInputType type,
        required String stringError,
        bool isPassword = false,
        var ontap,
        var onS,
        var onchanged,
        required String hintText,
        required IconData prefix,
        IconData? suffix,
        var suffixPressed}) =>
    Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.9,
        height: size.height * .065,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                offset: Offset.fromDirection(1.5, 10),
                spreadRadius: 0,
                blurRadius: 10.0),
          ],
          // s: BoxShadow(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextFormField(
          controller: controller,
          onChanged: onchanged,
          onFieldSubmitted: onS,
          keyboardType: type,
          validator: (value) {
            if (value!.isEmpty) {
              return stringError;
            }
          },
          onTap: ontap,
          obscureText: isPassword,
          //cursorColor: Colors.red,
          decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              prefix,
              color: Colors.grey,
            ),
            border: InputBorder.none,
          ),
        ));

Widget buildMyAccount(BuildContext context,Widget Screento,
        {required Size size, required String title, required IconData icon}) =>
    InkWell(
      onTap: (){
        navigateTo(context, Screento);
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: size.height * 0.022, horizontal: 20.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: size.width * .09,
              color: Colors.lightGreen,
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
final commonFirebaseStorageRepositoryProvider = Provider(
      (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}