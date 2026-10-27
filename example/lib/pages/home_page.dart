import 'package:cupertino_menu/cupertino_menu.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:example/util/util.dart';
import 'package:material_ui/material_ui.dart';

class const HomePage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupertino Menu'),
        actions: [
          CupertinoPopupMenuButton(
            actions: [
              CupertinoPopupMenuButtonAction(
                child: const Text('Select'),
                trailingIcon: CupertinoIcons.check_mark_circled,
                onPressed: () => logger.info('Select tapped'),
              ),
              CupertinoPopupMenuButtonAction(
                child: const Text('New Folder'),
                trailingIcon: CupertinoIcons.folder,
                onPressed: () {},
              ),
              CupertinoPopupMenuButtonAction(
                child: const Text('Scan Documents'),
                trailingIcon: CupertinoIcons.photo_camera,
                onPressed: () {},
              ),
              CupertinoPopupMenuButtonAction(
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
          30,
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
