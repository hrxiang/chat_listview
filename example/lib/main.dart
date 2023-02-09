import 'package:chat_listview/chat_listview.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final topList = <String>[];
  final bottomList = <String>[];

  // final controller = ScrollController();
  final controller = AutoScrollController();

  @override
  void initState() {
    bottomList.addAll(_buildNewMessage());
    super.initState();
  }

  void insert() {
    setState(() {
      topList.insert(0, '新消息');
    });
  }

  void add() {
    setState(() {
      bottomList.add('新消息');
    });
  }

  Future<bool> onScrollToBottomLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    bottomList.addAll(_buildNewMessage());
    return bottomList.length <= 88;
  }

  Future<bool> onScrollToTopLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    topList.insertAll(0, _buildHistoryMessage());
    return topList.length <= 88;
  }

  _buildNewMessage() {
    final list = <String>[];
    for (var i = 0; i < 20; i++) {
      list.add('新消息');
    }
    return list;
  }

  _buildHistoryMessage() {
    final list = <String>[];
    for (var i = 0; i < 20; i++) {
      list.add('历史消息');
    }
    return list;
  }

  void jumpToTop() {
    controller.scrollToTop();
  }

  void jumpToBottom() {
    controller.scrollToBottom();
  }

  void autoJumpToIndex() {
    controller.scrollToIndex(
      10,
      duration: const Duration(milliseconds: 1),
      preferPosition: AutoScrollPosition.begin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: jumpToTop,
                child: Text('跳到顶部'),
              ),
              ElevatedButton(
                onPressed: jumpToBottom,
                child: Text('跳到底部'),
              ),
              ElevatedButton(
                onPressed: autoJumpToIndex,
                child: Text('跳到 10'),
              ),
            ],
          ),
          Expanded(
            child: CustomChatListView<String>(
              itemBuilder: (_, index, position, dynamic data) {
                return AutoScrollTag(
                  key: ValueKey(position),
                  controller: controller,
                  index: position,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text('$data index:$index  position:$position'),
                  ),
                );
              },
              topList: topList,
              bottomList: bottomList,
              controller: controller,
              enabledBottomLoad: true,
              enabledTopLoad: true,
              onScrollToBottomLoad: onScrollToBottomLoad,
              onScrollToTopLoad: onScrollToTopLoad,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  insert();
                },
                child: Text('顶部插入数据'),
              ),
              ElevatedButton(
                onPressed: () {
                  add();
                },
                child: Text('底部插入数据'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
