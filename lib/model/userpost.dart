import 'usercomment.dart';

class Userpost {
  final String id; // storage key for this post's comments
  final String userimg;
  final String username;
  final String time;
  final String postcontent;
  final String postimg;
  final String numshare;
  bool isLiked;
  List<Usercomment> comments;

  Userpost({
    required this.id,
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    required this.numshare,
    required this.isLiked,
    List<Usercomment>? comments,
  }) : comments = comments ?? [];

  int get numcomments => comments.length;
}