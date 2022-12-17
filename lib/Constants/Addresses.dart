import 'package:kahtoo_messenger/Constants/AppMode.dart';

class AddressRepo {
  static String getURL() {
    Map<String, String> urls = {
      'debug_url': 'http://likerdshop.ir:7444/messenger',
      'release_url': 'http://likerdshop.ir:5000/messenger',
    };
    return AppMode.isDebugMode() ? urls['debug_url']! : urls['release_url']!;
  }

  static getSocketAddress() {
    //
    Map<String, String> urls = {
      'debug_url': 'ws://likerdshop.ir:7444/ws/messenger/',
      'release_url': 'ws://likerdshop.ir:7444/ws/messenger/',
    };
    return AppMode.isDebugMode() ? urls['debug_url']! : urls['release_url']!;
  }
}

class ScreenName {
  static String start = '/start';
  static String home = '/home';
  static String message = '/message';
  static String login = '/login';
  static String register = '/register';
  static String log = '/log';
  static String setting = '/setting';
  static String splash = '/splash';
  static String welcome = '/welcome';
}
