import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_agora_firebase/shared/components/compoents.dart';
import '../modules/Chat/ChatScreen.dart';
import '../shared/styles/colors.dart';
import 'Cubit/CubitBloc.dart';
import 'Cubit/StateBloc.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
     listener: (context, state) {},
     builder: (context, state) {
       var cubit = LayoutCubit.get(context);
       return DefaultTabController(
         length: 3,
         child: Scaffold(
           appBar: AppBar(
             title: Text('WhatsApp',style: TextStyle(fontSize: 23.sp),),
             actions: [
               Icon(Icons.camera_alt_outlined),
               SizedBox(
                 width: 20.w,
               ),Icon(Icons.search_outlined),
               SizedBox(
                 width: 20.w,
               ),
               Icon(Icons.more_vert_outlined),
               SizedBox(
                 width: 20.w,
               ),
             ],
             centerTitle: false,
             bottom: TabBar(
                 indicatorColor: Colors.white70,
                 indicatorWeight: 4,
                 labelColor: Colors.white,
                 unselectedLabelColor: Colors.grey[310],
                 labelStyle: TextStyle(
                   fontWeight: FontWeight.bold,
                 ),
                 tabs: <Widget>[
               Tab(text: "CHATS",),
               Tab(text: "STATUS",),
               Tab(text: "CALLS",),
             ]),
           ),
           floatingActionButton: FloatingActionButton(
             onPressed: () {},
             backgroundColor: tabColor,
             child: const Icon(
               Icons.comment,
               color: Colors.white,
             ),
           ),
           body: Container(
             width: double.infinity,
             child: Column(
               children: [
                 InkWell(
                   onTap: () {
                     navigateTo(context, ChatScreen());
                   },
                   child: Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                     child: Row(
                       children: [
                         Card(
                             shape: RoundedRectangleBorder(
                               borderRadius:
                               BorderRadius.circular(100.r),
                             ),
                             elevation: 3,
                             child: CircleAvatar(
                               radius: 30.r,
                               backgroundImage: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                               backgroundColor:  Color(0xff484848),
                             )
                         ),
                         SizedBox(width: 15.w,),
                         Container(
                           width: 190.w,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                   width: 190.w,
                                   child: Text('Ahmed Alzenati',style: TextStyle(fontSize: 18.sp),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                               Row(
                                 children: [

                                   Icon(Icons.done_all_outlined,color: Colors.cyan,),
                                   SizedBox(width: 2.w,),
                                   Container(
                                       width: 160.w,
                                       child: Text('اكك ماشي',style: TextStyle(color: Colors.grey[500]),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                 ],
                               ),
                             ],
                           ),
                         ),
                         Spacer(),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Text('12:00 am',style: TextStyle(fontSize: 12.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                             Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius:
                                   BorderRadius.circular(100.r),
                                 ),
                                 elevation: 3,
                                 child: CircleAvatar(
                                   radius: 10.r,
                                   backgroundColor:  Colors.green[300],
                                   child: Text('5',style: TextStyle(color: Colors.white,fontSize: 13.sp),),
                                 )
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ),),
       );
     },
          );
  }
}
