import 'package:get_storage/get_storage.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Screens/Chat/chat_screen.dart';
import 'package:kahtoo_messenger/Screens/Login/login_screen.dart';
import 'package:kahtoo_messenger/Screens/Register/register_screen.dart';
import 'package:kahtoo_messenger/Screens/Splash/splash_screen.dart';
import 'package:kahtoo_messenger/Screens/Message/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/Screens/Home/home.dart';
import 'package:kahtoo_messenger/Screens/Welcome/welcome_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kahtoo Messenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: ColorsRepo.getMainColor(),
          colorScheme: ColorScheme(
              primary: ColorsRepo.getMainColor(),
              secondary: ColorsRepo.getSecondColor(),
              brightness: Brightness.light,
              onBackground: ColorsRepo.getMainColor(),
              primaryContainer: ColorsRepo.getMainColor(),
              onPrimary: Colors.white,
              onSecondary: ColorsRepo.getMainColor(),
              onError: ColorsRepo.getMainColor(),
              secondaryContainer: ColorsRepo.getMainColor(),
              error: ColorsRepo.getMainColor(),
              surface: ColorsRepo.getSecondColor(),
              onSurface: ColorsRepo.getMainColor(),
              background: ColorsRepo.getMainColor())),
      getPages: [
        GetPage(name: ScreenName.home, page: () => const HomePage()),
        GetPage(name: ScreenName.message, page: () => MessageScreen()),
        GetPage(name: ScreenName.splash, page: () => const SplashScreen()),
        GetPage(name: ScreenName.login, page: () => const LoginScreen()),
        GetPage(name: ScreenName.register, page: () => const RegisterScreen()),
        GetPage(name: ScreenName.welcome, page: () => const WelcomeScreen()),
        GetPage(name: ScreenName.chat, page: () => const ChatScreen()),
      ],
      initialRoute: ScreenName.splash,
    );
  }
}
