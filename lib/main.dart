import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.dev/testing/ for more info.
  enableFlutterDriverExtension();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp()
    ),
  );
}

class Counter extends ChangeNotifier {
  int _value = 0;
  String _errorMessage = "";

  int get value => _value;
  String get errorMessage => _errorMessage;

  void increment() {
    if (_value < 10) {
      _value++;
      _errorMessage = "";
    } else {
      _errorMessage = "10以上にすることはできません";
    }
    notifyListeners();
  }

  void decrement() {
    if (_value > 0) {
      _value --;
      _errorMessage = "";
    } else {
      _errorMessage = "0以下にすることはできません";
    }
    notifyListeners();
  }

  void reset() {
    _value = 0;
    _errorMessage = "";
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.errorMessage}',
                style: TextStyle(color: Colors.red)
              ),
            ),
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              onPressed: () => Provider.of<Counter>(context, listen: false).decrement(),
              child: Text('minus'),
            ),
            RaisedButton(
              onPressed: () => Provider.of<Counter>(context, listen: false).reset(),
              child: Text('reset')
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<Counter>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}
