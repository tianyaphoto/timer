import 'dart:math';
import 'tweet_model.dart';

final random = Random();
// 一些预定义的句子片段，用于模拟推文内容
final List<String> tweetFragments = [
  "Had a great day at the park!",
  "Learning Flutter is so much fun!",
  "Just finished a 5k run.",
  "Cooked a delicious meal for dinner.",
  "The weather is lovely today.",
  "Reading a fascinating book about space exploration.",
  "Went to a fantastic concert last night.",
  "Working on a new side project.",
  "Spent quality time with family.",
  "Exploring new places in the city.",
];

void generateRandomTweets() {
  for (int i = 0; i < 20; i++) {
    // 随机选择一个句子片段作为推文内容
    String content = tweetFragments[random.nextInt(tweetFragments.length)];    
    Tweet newTweet = Tweet.createTweet("tweet $i - $content");
    tweets.addFirst(newTweet);
  }
}