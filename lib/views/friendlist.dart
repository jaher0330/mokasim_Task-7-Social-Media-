import 'package:flutter/material.dart';
import '../model/friend.dart';
import '../model/userdata.dart';
import 'safe_image.dart';

class Friendlist extends StatelessWidget {
  const Friendlist({super.key, required this.userdata});

  final Userdata userdata;

  final followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // FIX #4 (friend photo alignment):
  //  - every photo is cropped with BoxFit.cover so all tiles look the same
  //  - names are centered, one line, with ellipsis
  //  - a fixed childAspectRatio gives equal-size tiles on every screen
  Widget friend(Friend friend) => Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: safeAsset(friend.img, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                friend.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );

  Widget friendsListGrid() => GridView.builder(
        shrinkWrap: true,
        // The page already scrolls, so the grid must NOT scroll itself.
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: userdata.friendList.length,
        itemBuilder: (BuildContext ctx, index) {
          return friend(userdata.friendList[index]);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('Friends', style: followTxtStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('${userdata.friendList.length} Friends'),
        ),
        const SizedBox(height: 10),
        friendsListGrid(),
        const SizedBox(height: 10),
        Container(height: 10, color: Colors.grey.shade300),
      ],
    );
  }
}