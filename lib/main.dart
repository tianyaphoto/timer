import 'package:flutter/material.dart';
import 'package:timer/blank_page.dart';
import 'create_tweet_page.dart';
import 'tweets_page.dart';
import 'data_generator.dart';

void main() {
  generateRandomTweets();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mini Twitter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    TweetsPage(), 
    CreateTweetPage(),
    BlankPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Twitter'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tweets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tweets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: 'Profile'
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        ),
    );
  }
}
