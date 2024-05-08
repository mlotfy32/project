import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Screens/SplashViewBody.dart';
import 'package:food_app/StateManagment/cubit/login_cubit.dart';
import 'package:food_app/firebase_options.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? ProfileUrl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ProfileUrl = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: splashScreen(),
      ),
    );
  }
}
