import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasReplaced = false;
  final List<dynamic> _items = [];

  @override
  Widget build(BuildContext context) {

    if (!_hasReplaced && _items.isEmpty) {
      _initItems(1000); // 1000 hardcoded for now
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('FizzBuzz App'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _items.isNotEmpty ? _items.length : 0,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              _items[i].runtimeType == int
                ? _items[i].toString()
                : _items[i],
              style: const TextStyle(fontSize: 18)
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _hasReplaced
          ? Colors.red
          : Colors.green,
        onPressed: _hasReplaced
          ? _clearItems
          : _replaceWithFizzBuzz,
        child: _hasReplaced
          ? const Icon(Icons.restart_alt)
          : const Icon(Icons.check),
      ),
    );
  }

  void _initItems(int limit) {
    if (_items.isEmpty) {
      for (int i = 1; i <= limit; i++){
        _items.add(i);
      }
    }
  }

  void _toggleButton() {
    _hasReplaced = !_hasReplaced;
  }

  void _clearItems() {
    setState(() {
       _toggleButton();
      if (_items.isNotEmpty) {
        _items.clear();
      }
    });
  }

  void _replaceWithFizzBuzz() {
    setState(() {
       _toggleButton();
      if (_items.isNotEmpty) {
        for (int i = 0; i < _items.length; i++) {
          _items[i] = Util.doFizzBuzz(_items[i]);
        }
      }
    });
  }
}

class Util {
  Util();

  static String doFizzBuzz(int number) {
    String output = number.toString();
    if (number % 3 == 0 && number % 5 == 0) {
      output = 'FizzBuzz';
    } else if (number % 3 == 0) {
      output = 'Fizz';
    } else if (number % 5 == 0) {
      output = 'Buzz';
    }
    return output;
  }

}