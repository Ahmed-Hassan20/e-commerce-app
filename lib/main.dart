import 'package:e_commerce/Home%20Screen.dart';
import 'package:e_commerce/ui/auth/login/Login%20Screen.dart';
import 'package:e_commerce/utils/Splash%20Screen.dart';
import 'package:e_commerce/utils/my_theme.dart';
import 'package:e_commerce/ui/auth/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:Size(430, 932) ,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            initialRoute: LoginScreen.routename,
            routes: {
              SplashScreen.routename: (context) => SplashScreen(),
              RegisterScreen.routename: (context) => RegisterScreen(),
              LoginScreen.routename: (context) => LoginScreen(),
              HomeScreen.routename: (context) =>HomeScreen()
            },
            theme: mytheme.AppTheme
        );
      },

      );

  }
}

