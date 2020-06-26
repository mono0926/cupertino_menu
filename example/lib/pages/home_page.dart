import 'package:cupertino_menu/cupertino_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupertino Menu'),
        actions: [
          CupertinoPopupMenuButton(
            actions: [
              CupertinoContextMenuAction(
                child: const Text('Select'),
                trailingIcon: CupertinoIcons.check_mark_circled,
                onPressed: () {},
              ),
              CupertinoContextMenuAction(
                child: const Text('New Folder'),
                trailingIcon: CupertinoIcons.folder,
                onPressed: () {},
              ),
              CupertinoContextMenuAction(
                child: const Text('Scan Documents'),
                trailingIcon: CupertinoIcons.photo_camera,
                onPressed: () {},
              ),
              CupertinoContextMenuAction(
                child: const Text('Connect to Server'),
                trailingIcon: CupertinoIcons.collections,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: List.filled(
          10,
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Hello'),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
