import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/login_screen/login_screen.dart';
import 'bloc_observer.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(1920, 1024);
    win.minSize = initialSize;
    win.size = initialSize;
    win.maxSize = Size(1920, 1080);
    win.alignment = Alignment.center;
    win.title = "Gold'\s Gym";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white.withOpacity(0.2),
      ),
      debugShowCheckedModeBanner: false,
      home: LogInScreen(),
    );
  }
}
