import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import '../../Constants/Colors.dart';
import '../logs_screen.dart';
import '../Message/messages_screen.dart';
import '../setting_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        backgroundColor: ColorsRepo.getMainColor(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _currentIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.message),
            title: const Text('Messages'),
            activeColor: ColorsRepo.getMainColor(),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.history),
            title: const Text('History'),
            activeColor: ColorsRepo.getMainColor(),
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Setting'),
              activeColor: ColorsRepo.getMainColor()),
        ],
      ),
    );
  }
}
