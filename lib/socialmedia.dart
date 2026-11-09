import 'package:flutter/material.dart';
import 'model/userdata.dart';
import 'views/friendlist.dart';
import 'views/infoheader.dart';
import 'views/mainheader.dart';
import 'views/postlist.dart';

class Socialmedia extends StatefulWidget {
  const Socialmedia({super.key});

  @override
  State<Socialmedia> createState() => _SocialmediaState();
}

class _SocialmediaState extends State<Socialmedia> {
  Userdata userdata = Userdata();

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    // load the comments that were saved on the device
    userdata.loadComments().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TikTok'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      // The ONLY scrollable on this screen. Everything inside it
      // (friends grid, post list) is non-scrolling, so no gesture conflicts.
      body: ListView(
        children: [
          Mainheader(userdata: userdata),
          Infoheader(userdata: userdata),
          Friendlist(userdata: userdata),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(children: [Text('Posts', style: followTxtStyle)]),
          ),
          const SizedBox(height: 20),
          Postlist(userdata: userdata),
        ],
      ),
    );
  }
}