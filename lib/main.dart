import 'package:flutter/material.dart';
import 'package:pr5flutter/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late SharedPreferences sharedPreferences;

  TextEditingController text = TextEditingController();

  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _counter = sharedPreferences.getInt("counter") ?? 0;
  }

  @override
  void initState() {
    initShared();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    sharedPreferences.setInt("counter", _counter);
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });

    sharedPreferences.setInt("counter", _counter);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: _notifier,
        builder: (_, mode, __) {
          return Center(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: mode,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              home: Scaffold(
                body: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: text,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Screen(text: text.text),
                                ),
                              );
                            },
                            child: const Text("next page"),
                          ),
                        ],
                      ),
                    ),
                    Column(),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () => {
                          _notifier.value = mode == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light
                        }),
              ),
            ),
          );
        });
  }
}

class ScreenArguments {
  final String message;

  ScreenArguments(this.message);
}
