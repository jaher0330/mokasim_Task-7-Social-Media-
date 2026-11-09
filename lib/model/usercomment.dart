class Usercomment {
  final String commenterImg;
  final String commenterName;
  final String commentTime; // fallback label for seed comments
  final String commentContent;
  final int? createdAtMs; // set for comments added by the user

  Usercomment({
    required this.commenterImg,
    required this.commenterName,
    required this.commentTime,
    required this.commentContent,
    this.createdAtMs,
  });

  /// "Just now", "5 mins ago", "2 hrs ago", "3 days ago"
  String get timeLabel {
    if (createdAtMs == null) return commentTime;
    final diff = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(createdAtMs!));
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
    if (diff.inHours < 24) return '${diff.inHours} hrs ago';
    return '${diff.inDays} days ago';
  }

  Map<String, dynamic> toJson() => {
        'commenterImg': commenterImg,
        'commenterName': commenterName,
        'commentTime': commentTime,
        'commentContent': commentContent,
        'createdAtMs': createdAtMs,
      };

  factory Usercomment.fromJson(Map<String, dynamic> json) => Usercomment(
        commenterImg: json['commenterImg'] as String,
        commenterName: json['commenterName'] as String,
        commentTime: json['commentTime'] as String,
        commentContent: json['commentContent'] as String,
        createdAtMs: json['createdAtMs'] as int?,
      );
}