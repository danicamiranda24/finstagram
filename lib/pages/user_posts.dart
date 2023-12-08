import 'package:flutter/material.dart';

class UserPosts extends StatelessWidget {
  final String name;
  final NetworkImage networkImage;

  UserPosts(this.name, this.networkImage);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              //profile photo

              Icon(Icons.menu),
            ],
          ),
        ),
        //post
        Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: networkImage,
              fit: BoxFit.cover,
            ),
          ),
        ),

        //below the post -> buttons
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(
                      Icons.chat_bubble_outline,
                    ),
                  ),
                  Icon(
                    Icons.details_outlined,
                  ),
                ],
              ),
              Icon(
                Icons.bookmark_add_outlined,
              ),
            ],
          ),
        ),

        //comments
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Text(' Liked by '),
              Text(
                'dandani ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'and ',
                style: TextStyle(),
              ),
              Text(
                'others ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        //caption
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: 'utlajdsgg',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        ' ang ganda nman ng bebe girl na yan imissyou so much love'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
