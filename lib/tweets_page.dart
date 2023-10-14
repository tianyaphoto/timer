import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'tweet_model.dart';

class TweetsPage extends StatefulWidget {
  const TweetsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TweetsPageState createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  final ScrollController _scrollController = ScrollController();
  final int _tweetsPerPage = 10;

  int _loadedTweetsCount = 0;
  bool _isLoading = false; // 用于跟踪是否正在显示加载提示
  String _loadingMessage = 'Loading... ...';

  @override
  void initState() {
    super.initState();
    _loadMoreTweets();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreTweets();
    }

    // 当滚动到列表的顶部时
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      _showLoadingIndicator();
    }
  }

  void _showLoadingIndicator() async {
    setState(() {
      _isLoading = true;
      _loadingMessage = 'Loading... ...';
    });

    // 延迟2秒
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _loadingMessage = 'No more tweets.';
    });

    // 再延迟2秒
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  void _loadMoreTweets() {
    if (_loadedTweetsCount < tweets.length) {
      setState(() {
        _loadedTweetsCount += _tweetsPerPage;
        if (_loadedTweetsCount > tweets.length) {
          _loadedTweetsCount = tweets.length;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalTweetsCount = tweets.length;
    final showingEndOfList = _loadedTweetsCount >= totalTweetsCount;

    return tweets.isEmpty
        ? const Center(child: Text('No tweets yet. Start tweeting!'))
        : Stack(children: [
            ListView.builder(
              controller: _scrollController,
              itemCount: _loadedTweetsCount + 1,
              itemBuilder: (context, index) {
                if (index == _loadedTweetsCount) {
                  return showingEndOfList
                      ? const Center(child: Text('You have reached the end!'))
                      : const Center(child: CircularProgressIndicator());
                }

                // final tweet = totalTweetsCount - index <= 0 ? null : tweets.elementAt(totalTweetsCount - 1 - index);
                final tweet = tweets.elementAt(index);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  elevation: 4.0, // 添加阴影
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 213, 225, 231), // 更深的颜色
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(tweet!.avatarUrl),
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(tweet.username,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(DateFormat('y-MM-dd H:m')
                                    .format(tweet.timestamp)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(tweet.content),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const Icon(Icons.visibility),
                                const SizedBox(width: 4.0),
                                Text('${tweet.viewCount}'),
                                const SizedBox(width: 16.0),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (tweet.isLiked) {
                                        tweet.likeCount--;
                                      } else {
                                        tweet.likeCount++;
                                      }
                                      tweet.isLiked = !tweet.isLiked;
                                    });
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: tweet.isLiked
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                Text('${tweet.likeCount}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (_isLoading)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _loadingMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ]);
  }
}
