import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/Screens/Home/newChat_dialog.dart';
import 'package:kahtoo_messenger/Screens/Home/newGroup_dialog.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import '../../Constants/Colors.dart';
import '../../Models/my_model.dart';
import '../Groups/group_screen.dart';
import '../Message/messages_screen.dart';
import '../Setting/setting_screen.dart';

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
            GroupScreen(),
            SettingScreen(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentIndex == 0) {
            Get.dialog(
                WillPopScope(
                  onWillPop: () async => true,
                  child: NewChatDialog(),
                ),
                barrierDismissible: false);
          } else if (_currentIndex == 1) {
            Get.dialog(
                WillPopScope(
                  onWillPop: () async => true,
                  child: NewGroupDialog(),
                ),
                barrierDismissible: false);
          }
        },
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
            icon: const Icon(Icons.group),
            title: const Text('Groups'),
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
