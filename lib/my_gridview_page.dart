import 'package:flutter/material.dart';

class MyGridViewPage extends StatefulWidget {
  const MyGridViewPage({Key? key}) : super(key: key);

  @override
  State<MyGridViewPage> createState() => _MyGridViewPageState();
}

class _MyGridViewPageState extends State<MyGridViewPage> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _item = List.generate(20, (index) => 'Item $index');
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        _item.addAll(List.generate(20, (index) => 'Item ${_item.length + index}'));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          controller: _scrollController,
          itemCount: _item.length + (isLoading ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            if (index == _item.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridTile(child: Text(_item[index]));
            }
          },
        ),
      ),
    );
  }
}
