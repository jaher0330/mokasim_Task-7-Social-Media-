import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';
import 'comment_store.dart';

class Userdata {
  // Singleton: every screen sees the SAME posts and comments.
  static final Userdata _instance = Userdata._internal();
  factory Userdata() => _instance;
  Userdata._internal();

  bool _loaded = false;

  /// Load saved comments from the device (runs once).
  Future<void> loadComments() async {
    if (_loaded) return;
    for (final post in userList) {
      await CommentStore.load(post);
    }
    _loaded = true;
  }

  List<Userpost> userList = [
    Userpost(
      id: 'post1',
      userimg: 'assets/person1.jpg',
      username: 'John Doe',
      time: '2 hrs ago',
      postcontent: 'Had a great day at the beach!',
      postimg: 'assets/pavlova.jpg',
      numshare: '5',
      isLiked: false,
      comments: [
        Usercomment(
          commenterImg: 'assets/person2.jpg',
          commenterName: 'Jane Smith',
          commentTime: '1 hr ago',
          commentContent: 'Looks fun!',
        ),
        Usercomment(
          commenterImg: 'assets/person3.jpg',
          commenterName: 'Mike Johnson',
          commentTime: '30 mins ago',
          commentContent: 'Wish I was there!',
        ),
      ],
    ),
    Userpost(
      id: 'post2',
      userimg: 'assets/person2.jpg',
      username: 'Jane Smith',
      time: '3 hrs ago',
      postcontent: 'Loving the new cafe in town.',
      postimg: 'assets/pavlova.jpg',
      numshare: '3',
      isLiked: true,
      comments: [
        Usercomment(
          commenterImg: 'assets/person4.jpg',
          commenterName: 'Emily Davis',
          commentTime: '15 mins ago',
          commentContent: 'Great photo!',
        ),
      ],
    ),
    Userpost(
      id: 'post3',
      userimg: 'assets/person3.jpg',
      username: 'Mike Johnson',
      time: '5 hrs ago',
      postcontent: 'Just finished a 10k run!',
      postimg: 'assets/pavlova.jpg',
      numshare: '7',
      isLiked: false,
    ),
    Userpost(
      id: 'post4',
      userimg: 'assets/person4.jpg',
      username: 'Johnson Stewart',
      time: '5 hrs ago',
      postcontent: 'Just finished a 10k run!',
      postimg: 'assets/pavlova.jpg',
      numshare: '7',
      isLiked: false,
    ),
  ];

  List<Friend> friendList = [
    Friend(img: 'assets/person1.jpg', name: 'Alice'),
    Friend(img: 'assets/person2.jpg', name: 'Bob'),
    Friend(img: 'assets/person3.jpg', name: 'Charlie'),
    Friend(img: 'assets/person4.jpg', name: 'Diana'),
    Friend(img: 'assets/person5.jpg', name: 'Ethan'),
    Friend(img: 'assets/person6.jpg', name: 'Fiona'),
  ];

    Account myUserAccount = Account(
    name: 'Mokasim, John Jaher S',
    email: 'mokasimjohn23@gmail.com',
    img: 'assets/me.jpg',               
    numFollowers: '1 Million',
    numPosts: '350',
    numFollowing: '500',
    numFriends: '400',
  );
}