import 'package:flutter/material.dart';
import '../model/userdata.dart';
import 'safe_image.dart';

class Mainheader extends StatelessWidget {
  const Mainheader({super.key, required this.userdata});

  final Userdata userdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvatarImage(path: userdata.myUserAccount.img, radius: 40),
        const SizedBox(height: 8),
        Text(
          userdata.myUserAccount.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
        Text(userdata.myUserAccount.email),
        const SizedBox(height: 20),
      ],
    );
  }
}