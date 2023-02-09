![image](https://github.com/hrxiang/chat_listview/tree/main/images/a.gif)

1，第一次加载数据存入bottomList

```
    bottomList.addAll(_buildNewMessage());
```

2，新收到消息

```
    bottomList.add('新消息');
```

3，历史消息

```
    topList.insert(0, '历史消息');
```

4，滚动到底部

```
    controller.scrollToBottom();
```

5，滚动到顶部

```
  controller.scrollToTop();
```

6，滚动到指定index，配合"scroll_to_index"库一起使用

```
  void autoJumpToIndex(position) {
    controller.scrollToIndex(
      position,
      duration: const Duration(milliseconds: 1),
      preferPosition: AutoScrollPosition.begin,
    );
  }
```

7，滚动到顶部加载更多

```
  Future<bool> onScrollToTopLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    topList.insertAll(0, _buildHistoryMessage());
    return topList.length <= 88;
  }
```

8，滚动到底部加载更多

```
  Future<bool> onScrollToBottomLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    bottomList.addAll(_buildNewMessage());
    return bottomList.length <= 88;
  }
```