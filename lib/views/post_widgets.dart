import 'package:flutter/material.dart';
import '../model/userpost.dart';
import 'safe_image.dart';

var nametxtstyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

/// userline: avatar + username + time
class PostHeader extends StatelessWidget {
  const PostHeader({super.key, required this.userPost});

  final Userpost userPost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarImage(path: userPost.userimg, radius: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userPost.username,
                    style: nametxtstyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(userPost.time),
                    const Text(' . '),
                    const Icon(Icons.group, size: 15, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// postimage: caption + picture
class PostImage extends StatelessWidget {
  const PostImage({super.key, required this.userPost});

  final Userpost userPost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userPost.postcontent),
          const SizedBox(height: 15),
          SizedBox(
            height: 350,
            width: double.infinity,
            child: safeAsset(userPost.postimg, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}

/// Like / Comment / Share row
class PostButtons extends StatelessWidget {
  const PostButtons({
    super.key,
    required this.userPost,
    required this.onLike,
    required this.onComment,
  });

  final Userpost userPost;
  final VoidCallback onLike;
  final VoidCallback onComment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor:
                      userPost.isLiked ? Colors.blue : Colors.grey,
                ),
                onPressed: onLike,
                icon: const Icon(Icons.thumb_up, size: 20),
                label: const Text('Like'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                onPressed: onComment,
                icon: const Icon(Icons.chat_bubble, size: 20),
                label: Text('Comment (${userPost.numcomments})'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                onPressed: () {},
                icon: const Icon(Icons.share, size: 20),
                label: const Text('Share'),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}