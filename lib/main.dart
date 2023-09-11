
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/Helper/Theme/Theme.dart';
import 'package:final_project/Helper/bloc-s.dart';
import 'package:final_project/SplashScreen/SplashScreen.dart';
import 'package:final_project/StateManagemnt/EditProfile/cubit.dart';
import 'package:final_project/StateManagemnt/EditProfile/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(EasyLocalization(
      supportedLocales:  const [Locale('en', 'US'), Locale('ar', 'DZ')],
      path: 'lib/assets/lang',
      fallbackLocale: const Locale('en', 'US'),
      child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c)=>EditProfileCubit(),
      child: BlocConsumer<EditProfileCubit,EditProfileStates>(
        builder: (c,state){
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Classy Closet',
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: c.read<EditProfileCubit>().isLightMood ? ThemeMode.light : ThemeMode.dark,

            home: const SplashScreen(),
          );
        },
        listener: (c,state){},
      ),
    );
  }
}

