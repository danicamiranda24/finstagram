import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  FireBaseService? _firebaseService;
  int _currentPage = 0;
  final List<Widget> _pages = [
    FeedPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FireBaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finstagram",
          style: TextStyle(fontFamily: 'Vidaloka-Regular', color: Colors.white),
        ),
        actions: [
          _gestureDetector(
            Icons.add_a_photo,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: _gestureDetector(Icons.logout),
          ),
        ],
        backgroundColor: Colors.red.withOpacity(0.90),
        shape: const RoundedRectangleBorder(
            // borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(25),
            // bottomRight: Radius.circular(25),
            // ),
            ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _pages[_currentPage],

    );
  }

  Widget _gestureDetector(IconData? _iconvalue) {
    return GestureDetector(
      onTap: _postImage,
      child: Icon(_iconvalue),
    );
  }

  Widget _bottomNavigationBar() {
    return NavigationBar(
      destinations:  [
        NavigationDestination(
          icon: Icon(
            Icons.home_filled,
            color: Colors.grey.shade800,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          label: 'Profile',
          icon: Icon(
            Icons.account_box,
            color: Colors.grey.shade800,
          ),
        ),
      ],
      selectedIndex: _currentPage,
      onDestinationSelected: (int _index) {
        setState(() {
          _currentPage = _index;
        });
      },
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: Colors.red.withOpacity(0.90),
      indicatorColor: Colors.white,
    );
  }

  void _postImage() async {
    FilePickerResult? _result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    File _image = File(_result!.files.first.path!);
    await _firebaseService!.postImage(_image);
  }
}
