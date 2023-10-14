// ignore: use_function_type_syntax_for_parameters
test('test tweet card', () {
  final tweets = [
    Tweet(
      avatarUrl: 'https://example.com/avatar.png',
      username: 'example_user',
      content: 'This is an example tweet',
    ),
  ];

  final widget = MaterialApp(
    home: Scaffold(
      body: TweetsPage(tweets: tweets),
    ),
  );

  final tester = await TestWidgetsFlutterBinding.ensureInitialized().createWidgetTester();
  await tester.pumpWidget(widget);

  final tweetCardFinder = find.byType(Card);
  expect(tweetCardFinder, findsOneWidget);

  final avatarFinder = find.byType(CircleAvatar);
  expect(avatarFinder, findsOneWidget);

  final usernameFinder = find.text('example_user');
  expect(usernameFinder, findsOneWidget);

  final contentFinder = find.text('This is an example tweet');
  expect(contentFinder, findsOneWidget);
});