import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
 final List<Widget> _pages = [
    FeedPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finstagram",
        ),
        actions: [
          _gestureDetector(Icons.add_a_photo),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: _gestureDetector(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _pages[_currentPage],
    );
  }

  Widget _gestureDetector(IconData? _iconvalue) {
    return GestureDetector(
      onTap: () {},
      child: Icon(_iconvalue),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (_index) {
        setState(() {
          _currentPage = _index;
        });
      },
      currentIndex: _currentPage,
      items: const [
        BottomNavigationBarItem(
          label: 'Feed',
          icon: Icon(Icons.feed),
        ),
        BottomNavigationBarItem(
          label: 'Feed',
          icon: Icon(Icons.account_box),
        ),
      ],
    );
  }
}
