import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appStatus = 'start';
  int userInput = 0;
  bool _submitted = false;
  final List<dynamic> _items = [];
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if (appStatus == 'inProgress' && _items.isEmpty) {
      _initItems(userInput);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('FizzBuzz App'),
      ),
      body: appStatus != 'start'
      ? ItemListWidget(_items)
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'FizzBuzz App will generate a list of numbers!',
                style: TextStyle(fontSize: 16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter the Upper Limit',
                errorText: _submitted ? _errorText : null
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _handleUserInput,
                child: const Text('Generate'),
              ),
            ),
          ),
        ]
      ),
      floatingActionButton: appStatus != 'start'
      ? appStatus == 'inProgress'
        ? ActionButtonWidget(Colors.green, _replaceWithFizzBuzz, const Icon(Icons.start), 'Run')
        : ActionButtonWidget(Colors.red, _clearItems, const Icon(Icons.restart_alt), 'Reset')
      : null,
    );
  }

  String get _errorText {
    final text = myController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (double.tryParse(text) == null) {
      return 'Must be a number';
    }
    return '';
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _initItems(int limit) {
    if (_items.isEmpty) {
      for (int i = 1; i <= limit; i++){
        _items.add(i);
      }
    }
  }

  void _switchAppStatus() {
    setState(() {
      String newStatus = appStatus;
      switch(appStatus) {
        case 'start':
          newStatus = 'inProgress';
          break;
        case 'inProgress':
          newStatus = 'end';
          break;
        case 'end':
          newStatus = 'start';
          break;
        default:
          break;
      }
      appStatus = newStatus;
    });
  }

  void _clearInput() {
    setState(() {
      userInput = 0;
      _submitted = false;
      myController.clear();
    });
  }

  void _clearItems() {
    setState(() {
      if (_items.isNotEmpty) {
        _items.clear();
      }
      _switchAppStatus();
      _clearInput();
    });
  }

  void _replaceWithFizzBuzz() {
    setState(() {
       _switchAppStatus();
      if (_items.isNotEmpty) {
        for (int i = 0; i < _items.length; i++) {
          _items[i] = Util.doFizzBuzz(_items[i]);
        }
      }
    });
  }

  void _handleUserInput() {
    setState(() {
      _submitted = true;
      if (_errorText == '') {
        userInput = int.parse(myController.text);
        _switchAppStatus();
      }
    });
  }
}

class ItemListWidget extends StatelessWidget {
  final List<dynamic> items;
  const ItemListWidget(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.isNotEmpty ? items.length : 0,
      itemBuilder: (context, i) {
        return Card(
          color: _cardBackgroundColor(items[i]),
          child: ListTile(
            title: Center(
              child: Text(
                items[i].runtimeType == int
                  ? items[i].toString()
                  : items[i],
                style: const TextStyle(fontSize: 18)
              ),
            ),
          ),
        );
      }
    );
  }

  Color _cardBackgroundColor(var item) {
    Color backgroundColor = Colors.white12;
    if (item.runtimeType == String) {
      if (item == 'Fizz') {
        backgroundColor = Colors.green;
      } else if (item == 'Buzz') {
        backgroundColor = Colors.red;
      } else if (item == 'FizzBuzz') {
        backgroundColor = Colors.orange;
      }
    }
    return backgroundColor;
  }

}

class ActionButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final void Function() callback;
  final Icon icon;
  final String label;

  const ActionButtonWidget(this.backgroundColor, this.callback, this.icon, this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: backgroundColor,
      onPressed: callback,
      icon: icon,
      label: Text(label)
    );
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