import 'package:flutter/material.dart';
import 'tweet_model.dart';

class CreateTweetPage extends StatefulWidget {
  const CreateTweetPage({super.key});

  @override
  _CreateTweetPageState createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  final _tweetController = TextEditingController();

  void _postTweet() {
    final tweetContent = _tweetController.text;
    if (tweetContent.isNotEmpty) {
      tweets.addFirst(Tweet.createTweet(tweetContent));

      _tweetController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tweet Posted!')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _tweetController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'What\'s happening?',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12.0),
          ElevatedButton(onPressed: _postTweet, child: const Text('Tweet'),),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tweetController.dispose();
    super.dispose();
  }
}
