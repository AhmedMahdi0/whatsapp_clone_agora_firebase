import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_agora_firebase/firebase_options.dart';
import 'package:whatsapp_clone_agora_firebase/shared/styles/themes.dart';
import 'Layout/Cubit/CubitBloc.dart';
import 'Layout/Cubit/StateBloc.dart';
import 'Layout/LayoutScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  runApp(MyApp());

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Initialized default app $app');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(377, 813),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context , child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  darkTheme: darkTheme(context),
                  theme: ligthTheme(context),
                  themeMode: ThemeMode.light,
                  home: child,
                );
              },
              child:  LayoutScreen(),
            );
            // return MaterialApp(

            //
            //   home: LayoutScreen(),
            // );
          }),
    );
  }
}