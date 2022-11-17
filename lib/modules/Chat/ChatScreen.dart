import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../../shared/styles/info.dart';
import 'chat_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            IconBroken.Arrow___Left_2,
          ),
        ),
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundImage: NetworkImage(
                'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
                width: 150.w,
                child: Text(info[0]['name'].toString(),style: TextStyle(fontSize: 20.sp,),maxLines: 1,overflow: TextOverflow.ellipsis,),),
          ],
        ),
        actions: [
          Icon(Icons.videocam_rounded),
          SizedBox(
            width: 15.w,
          ),
          Icon(Icons.call),
          SizedBox(
            width: 15.w,
          ),
          Icon(Icons.more_vert),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
              fit: BoxFit.cover,
            )),
          ),
          Column(
            children: [
              const Expanded(
                child: ChatList(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 10.h, start: 4.w),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: mobileChatBoxColor,
                          prefixIcon:  Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: Icon(
                              Icons.emoji_emotions,
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding:
                                 EdgeInsets.symmetric(horizontal: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.attach_file,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Type a message!',

                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 10.h, end: 5.w),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        elevation: 3,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundColor: tabColor,
                          child: Icon(
                            Icons.keyboard_voice_sharp,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
