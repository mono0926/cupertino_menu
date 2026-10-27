import 'package:flutter_portal/flutter_portal.dart';
import 'package:material_ui/material_ui.dart';

import 'pages/pages.dart';

class const App({super.key}) extends StatelessWidget {
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
