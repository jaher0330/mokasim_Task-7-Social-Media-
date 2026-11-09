import 'package:flutter/material.dart';
import '../model/comment_store.dart';
import '../model/userdata.dart';
import '../model/usercomment.dart';
import '../model/userpost.dart';
import 'post_widgets.dart';
import 'safe_image.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.userPost,
    required this.userdata,
    this.focusCommentBox = false,
  });

  final Userpost userPost;
  final Userdata userdata;
  final bool focusCommentBox;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode commentFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.focusCommentBox) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) commentFocus.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    commentFocus.dispose();
    super.dispose();
  }

  // FEATURE #3: add a comment, save it, show it.
  Future<void> addComment() async {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    final me = widget.userdata.myUserAccount;
    setState(() {
      widget.userPost.comments.add(
        Usercomment(
          commenterImg: me.img,
          commenterName: me.name,
          commentTime: 'Just now',
          commentContent: text,
          createdAtMs: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });
    commentController.clear();

    // scroll down so the new comment is visible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // save to the device so it is still there after restarting the app
    await CommentStore.save(widget.userPost);
  }

  Widget commentTile(Usercomment c) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarImage(path: c.commenterImg, radius: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.commenterName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(c.timeLabel,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(c.commentContent),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget commentBar() => SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 8, 6, 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  focusNode: commentFocus,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => addComment(),
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: addComment,
                icon: const Icon(Icons.send, color: Colors.blue),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final post = widget.userPost;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      // One scrollable only (the ListView). The comment box sits below it.
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                PostHeader(userPost: post),
                PostImage(userPost: post),
                PostButtons(
                  userPost: post,
                  onLike: () => setState(() => post.isLiked = !post.isLiked),
                  onComment: () => commentFocus.requestFocus(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                  child: Text('Comments (${post.numcomments})',
                      style: nametxtstyle),
                ),
                if (post.comments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No comments yet. Be the first to comment!',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ...post.comments.map(commentTile),
                const SizedBox(height: 12),
              ],
            ),
          ),
          commentBar(),
        ],
      ),
    );
  }
}