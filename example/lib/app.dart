import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import 'pages/pages.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    const title = 'mono_kit Demo';
    return MaterialApp(
      navigatorKey: context.watch(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      title: title,
      home: const HomePage(),
      onGenerateRoute: Provider.of<Router>(context).onGenerateRoute,
      builder: (context, child) => Portal(
        child: child,
      ),
    );
  }
}
