import 'package:kahtoo_messenger/Constants/AppMode.dart';

class AddressRepo {
  static String getURL() {
    Map<String, String> urls = {
      'debug_url': 'http://likerdshop.ir:7448/exchange',
      'release_url': 'http://likerdshop.ir:5000/exchange',
    };
    return AppMode.isDebugMode() ? urls['debug_url']! : urls['release_url']!;
  }
}
