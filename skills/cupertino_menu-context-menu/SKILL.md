---
name: cupertino_menu-context-menu
description: >-
  Use when implementing iOS-style contextual popup menus and action lists anchored
  to specific widgets or navigation bar buttons using cupertino_menu.
---

# cupertino_menu Context Menu Guide

`cupertino_menu` renders iOS-style contextual pop-up menus (introduced in iOS 14). It opens with smooth scaling transitions anchored directly to the triggering button.

## Guidelines

- **Portal Host Requirement**:
  - `cupertino_menu` relies on `flutter_portal` for rendering overlay portals. Ensure `Portal` wraps your root app widget (e.g. above or inside `MaterialApp` / `CupertinoApp`).
- **Triggering Menus**:
  - Replace standard popup buttons with `CupertinoPopupMenuButton(actions: [...])`.
  - Provide a list of `CupertinoPopupMenuButtonAction` objects containing titles, optional icons, and `onPressed` callbacks.
- **Handling Action Callbacks**:
  - Each `CupertinoPopupMenuButtonAction.onPressed` is triggered when tapped, and the popup automatically dismisses itself.
- **Device Rotation**:
  - The menu automatically listens to `MediaQuery.of(context).orientation` and dismisses on device rotation to avoid misaligned anchors.

## Examples

### 1. Basic Setup with Root Portal

```dart
import 'package:cupertino_menu/cupertino_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  runApp(
    const Portal(
      child: CupertinoApp(
        home: HomeScreen(),
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Cupertino Menu'),
        trailing: CupertinoPopupMenuButton(
          actions: [
            CupertinoPopupMenuButtonAction(
              title: const Text('View Profile'),
              onPressed: () => debugPrint('Navigate to profile'),
            ),
            CupertinoPopupMenuButtonAction(
              title: const Text('Settings'),
              onPressed: () => debugPrint('Navigate to settings'),
            ),
            CupertinoPopupMenuButtonAction(
              title: const Text('Logout', style: TextStyle(color: CupertinoColors.destructiveRed)),
              onPressed: () => debugPrint('Logout pressed'),
            ),
          ],
        ),
      ),
      child: const Center(
        child: Text('Tap the top-right button for menu'),
      ),
    );
  }
}
```

## Common Pitfalls & Anti-Patterns

- ❌ **Anti-pattern**: Forgetting to add `Portal` in the widget hierarchy, causing `PortalEntry` errors at runtime.
  - ✔️ **Correct**: Wrap `CupertinoApp` or `MaterialApp` inside `Portal`.
- ❌ **Anti-pattern**: Manually calling `Navigator.pop()` inside `CupertinoPopupMenuButtonAction.onPressed`.
  - ✔️ **Correct**: Do not call `Navigator.pop()`; the button action handles closing the menu internally.
