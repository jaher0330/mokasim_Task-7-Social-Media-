import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'userpost.dart';
import 'usercomment.dart';

/// Saves / loads the comments of each post on the device,
/// so they are still there after closing the app.
class CommentStore {
  static String _key(String postId) => 'comments_$postId';

  static Future<void> save(Userpost post) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(post.comments.map((c) => c.toJson()).toList());
    await prefs.setString(_key(post.id), encoded);
  }

  static Future<void> load(Userpost post) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(post.id));
    if (raw == null) return; // nothing saved yet, keep the seed comments
    final list = jsonDecode(raw) as List<dynamic>;
    post.comments = list
        .map((e) => Usercomment.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}