import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Views/Screens/logs_screen.dart';
import 'package:kahtoo_messenger/Views/Screens/messages_screen.dart';
import 'package:kahtoo_messenger/Views/Screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        backgroundColor: ColorsRepo.getMainColor(),
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
        backgroundColor: ColorsRepo.getMainColor(),
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
            icon: const Icon(Icons.message),
            title: const Text('Messages'),
            activeColor: ColorsRepo.getMainColor(),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.history),
            title: Text('History'),
            activeColor: ColorsRepo.getMainColor(),
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Setting'),
              activeColor: ColorsRepo.getMainColor()),
        ],
      ),
    );
  }
}
