import 'package:flutter/material.dart';

class AppLifeCycle extends StatefulWidget {
  const AppLifeCycle({super.key});

  @override
  State<AppLifeCycle> createState() => _AppLifeCycleState();
}

class _AppLifeCycleState extends State<AppLifeCycle>
    with WidgetsBindingObserver {
  AppLifecycleState? _notification;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    print('Current state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return Text('Last notification: $_notification');
  }
}
