### 一个可以从顶部或底部插入数据不引起位置改变的listview，用在聊天列表当查看历史消息或其他操作时新增消息而不会引起列表滚动。

[![pub package](https://img.shields.io/pub/v/chat_listview.svg)](https://pub.flutter-io.cn/packages/chat_listview)

![image](https://github.com/hrxiang/chat_listview/blob/main/images/img.png)
![image](https://github.com/hrxiang/chat_listview/blob/main/images/a.gif)

1，创建CustomChatListViewController实例： controller

```
    controller = CustomChatListViewController([]);
```

2，向顶部插入数据

```
   controller.insertToTop('历史消息');
```

3，向底部插入数据

```
   controller.insertToBottom('新消息');
```

4，滚动到底部

```
   scrollController.scrollToBottom();
```

5，滚动到顶部

```
   scrollController.scrollToTop();
```

6，滚动到指定index，配合"scroll_to_index"库一起使用

```
  scrollController.scrollToIndex(
      position,
      duration: const Duration(milliseconds: 1),
      preferPosition: AutoScrollPosition.begin,
  );
```

7，滚动到顶部加载更多，返回true还有未加载数据，false已经加载了所有数据

```
  Future<bool> onScrollToTopLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    controller.insertAllToTop(_buildHistoryMessage());
    return controller.topHasMore(max: 88);
  }
```

8，滚动到底部加载更多

```
  Future<bool> onScrollToBottomLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    controller.insertAllToBottom(_buildNewMessage());
    return controller.bottomHasMore(max: 88);
  }
```
