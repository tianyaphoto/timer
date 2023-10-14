import 'dart:math';
import 'dart:collection';

final random = Random();

class Tweet {
  final String username;
  final String avatarUrl;
  final DateTime timestamp;
  final String content;
  
  int viewCount;
  int likeCount;
  bool isLiked;
  

  Tweet({
    required this.username,
    required this.avatarUrl,
    required this.timestamp,
    required this.content,
    required this.viewCount,
    required this.likeCount,
    this.isLiked = false,
  });

  // 静态方法来快速创建 Tweet
  static Tweet createTweet(String content) {
    // 为了示例，我们假设观看次数在 0 到 9999 之间，点赞次数在 0 到 999 之间
    final randomViewCount = random.nextInt(10000);
    final randomLikeCount = random.nextInt(1000);

    return Tweet(
      username: "Bill",
      avatarUrl: "https://p4.itc.cn/images01/20230526/7368c9190b9546798d4b24e8253024f9.jpeg",
      timestamp: DateTime.now(),
      content: content,
      viewCount: randomViewCount,
      likeCount: randomLikeCount,
    );
  }
} 

Queue<Tweet> tweets = Queue<Tweet>();
