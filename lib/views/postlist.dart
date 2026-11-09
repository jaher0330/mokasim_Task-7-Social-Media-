import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import 'post_widgets.dart';
import 'profile_view.dart';

class Postlist extends StatefulWidget {
  const Postlist({super.key, required this.userdata});

  final Userdata userdata;

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  Future<void> openPost(Userpost post, {bool focusComment = false}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileView(
          userPost: post,
          userdata: widget.userdata,
          focusCommentBox: focusComment,
        ),
      ),
    );
    // Refresh so the new comment count shows up in the list.
    if (mounted) setState(() {});
  }

  Widget showPost(Userpost userPost) => Column(
        children: [
          PostHeader(userPost: userPost),
          PostImage(userPost: userPost),
          PostButtons(
            userPost: userPost,
            onLike: () => setState(() => userPost.isLiked = !userPost.isLiked),
            onComment: () => openPost(userPost, focusComment: true),
          ),
          const SizedBox(height: 10),
          Container(height: 10, color: Colors.grey.shade300),
          const SizedBox(height: 15),
        ],
      );

  // FIX #1 (list view bug):
  // Before: SingleChildScrollView > ListView(shrinkWrap) inside the page's
  // own ListView = 3 nested scrollables fighting over touch gestures, which
  // freezes/jitters scrolling on a physical phone.
  // Now: a plain Column. The page's ONE ListView does all the scrolling.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.userdata.userList.map((userPost) {
        return InkWell(
          onTap: () => openPost(userPost),
          child: showPost(userPost),
        );
      }).toList(),
    );
  }
}