import 'package:kahtoo_messenger/helper/basicinfo.dart';
import 'package:kahtoo_messenger/screens/logs_screen.dart';
import 'package:kahtoo_messenger/screens/messages_screen.dart';
import 'package:kahtoo_messenger/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: BasicInfo.getMainColor(),
          colorScheme: ColorScheme(
              primary: BasicInfo.getMainColor(),
              secondary: BasicInfo.getSecondColor(),
              brightness: Brightness.light,
              onBackground: BasicInfo.getMainColor(),
              primaryContainer: BasicInfo.getMainColor(),
              onPrimary: Colors.white,
              onSecondary: BasicInfo.getMainColor(),
              onError: BasicInfo.getMainColor(),
              secondaryContainer: BasicInfo.getMainColor(),
              error: BasicInfo.getMainColor(),
              surface: BasicInfo.getSecondColor(),
              onSurface: BasicInfo.getMainColor(),
              background: BasicInfo.getMainColor())),
      home: MyMainScreen(),
    );
  }
}

class MyMainScreen extends StatefulWidget {
  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kahtoo Messenger"),
        backgroundColor: BasicInfo.getMainColor(),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MessageScreen(),
            LogsScreen(),
            SettingScreen(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: BasicInfo.getMainColor(),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _currentIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages'),
            activeColor: BasicInfo.getMainColor(),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
            activeColor: BasicInfo.getMainColor(),
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Setting'),
              activeColor: BasicInfo.getMainColor()),
        ],
      ),
    );
  }
}
