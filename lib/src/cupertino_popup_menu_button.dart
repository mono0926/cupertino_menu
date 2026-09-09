import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

/// An iOS-style popup menu button that displays an action sheet menu
/// anchored to the button when pressed.
class CupertinoPopupMenuButton extends StatefulWidget {
  /// Creates an iOS-style popup menu button.
  const CupertinoPopupMenuButton({
    super.key,
    required this.actions,
  });

  /// The list of actions to show in the popup menu.
  final List<CupertinoPopupMenuButtonAction> actions;

  @override
  State<CupertinoPopupMenuButton> createState() =>
      _CupertinoPopupMenuButtonState();
}

class _CupertinoPopupMenuButtonState extends State<CupertinoPopupMenuButton>
    with SingleTickerProviderStateMixin {
  var _isOpened = false;
  late final AnimationController _animationController;
  late final Animation<Matrix4> _transformAnimation;
  Orientation? _orientation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);

    _transformAnimation = _animationController
        .drive(
          // TODO(mono): Change for reverse
          CurveTween(curve: Curves.easeOutQuint),
        )
        .drive(
          Matrix4Tween(
            begin: Matrix4.diagonal3Values(0.01, 0.01, 1),
            end: Matrix4.identity(),
          ),
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orientation = MediaQuery.of(context).orientation;
    if (_orientation != null && _orientation != orientation) {
      unawaited(_close());
    }
    _orientation = orientation;
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: _isOpened,
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => unawaited(_close()),
      ),
      child: PortalTarget(
        visible: _isOpened,
        anchor: const Aligned(
          follower: Alignment(1.05, -0.95),
          target: Alignment.bottomRight,
        ),
        portalFollower: AnimatedBuilder(
          animation: _transformAnimation,
          builder: (context, child) {
            return Transform(
              transform: _transformAnimation.value,
              alignment: const Alignment(0.9, -1),
              child: child,
            );
          },
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.17),
                  blurRadius: 80,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.actions
                    .map(
                      (action) => CupertinoContextMenuAction(
                        isDefaultAction: action.isDefaultAction,
                        isDestructiveAction: action.isDestructiveAction,
                        onPressed: () {
                          unawaited(_close());
                          action.onPressed?.call();
                        },
                        trailingIcon: action.trailingIcon,
                        child: action.child,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        child: IconButton(
          icon: const Icon(CupertinoIcons.ellipsis),
          onPressed: _open,
        ),
      ),
    );
  }

  void _open() {
    if (_isOpened) {
      return;
    }
    setState(() {
      _isOpened = true;
    });
    _animationController
      ..duration = const Duration(milliseconds: 300)
      ..forward();
  }

  Future<void> _close() async {
    if (!_isOpened) {
      return;
    }
    _animationController.duration = const Duration(milliseconds: 200);
    await _animationController.reverse();
    setState(() {
      _isOpened = false;
    });
  }
}

/// An action item displayed in a [CupertinoPopupMenuButton].
class CupertinoPopupMenuButtonAction {
  /// Creates an action item for [CupertinoPopupMenuButton].
  const CupertinoPopupMenuButtonAction({
    required this.child,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    this.trailingIcon,
  });

  /// The widget to display inside the action button (typically a [Text]).
  final Widget child;

  /// Whether this action is the default action for the menu.
  final bool isDefaultAction;

  /// Whether this action deletes data or performs an irreversible action.
  final bool isDestructiveAction;

  /// The callback that is called when the action is tapped.
  final VoidCallback? onPressed;

  /// An optional icon displayed at the trailing end of the action.
  final IconData? trailingIcon;
}
