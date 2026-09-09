import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

import 'pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino Menu Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Portal(
        child: HomePage(),
      ),
    );
  }
}
