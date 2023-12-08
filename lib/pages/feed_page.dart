import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/pages/user_posts.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedPageState();
  }
}

class _FeedPageState extends State<FeedPage> {
  FireBaseService? _fireBaseService;
  double? _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    _fireBaseService = GetIt.instance.get<FireBaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      child: _userPostUI(),
    );
  }

  Widget _postsListView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireBaseService!.getLatestPosts(),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            List _posts = _snapshot.data!.docs.map((e) => e.data()).toList();
            print(_posts);
            return ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (BuildContext context, int index) {
                Map _post = _posts[index];
                return Container(
                  height: _deviceHeight! * 0.30,
                  margin: EdgeInsets.symmetric(
                      vertical: _deviceHeight! * 0.01,
                      horizontal: _deviceWidth! * 0.05),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        _post["image"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _postsListView2() {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireBaseService!.getLatestPosts(),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            List _posts = _snapshot.data!.docs.map((e) => e.data()).toList();
            print(_posts);
            return ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (BuildContext context, int index) {
                Map _post = _posts[index];
                return Container(
                  height: _deviceHeight! * 0.30,
                  margin: EdgeInsets.symmetric(
                      vertical: _deviceHeight! * 0.01,
                      horizontal: _deviceWidth! * 0.05),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        _post["image"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _userPostUI() {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireBaseService!.getLatestPosts(),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            List _posts = _snapshot.data!.docs.map((e) => e.data()).toList();
            print(_posts);
            return ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (BuildContext context, int index) {
                Map _post = _posts[index];
                return UserPosts('Chandria', NetworkImage(_post["image"]));
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
