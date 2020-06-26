import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class CupertinoPopupMenuButton extends StatefulWidget {
  const CupertinoPopupMenuButton({
    Key key,
    @required this.actions,
  }) : super(key: key);

  final List<CupertinoPopupMenuButtonAction> actions;

  @override
  _CupertinoPopupMenuButtonState createState() =>
      _CupertinoPopupMenuButtonState();
}

class _CupertinoPopupMenuButtonState extends State<CupertinoPopupMenuButton>
    with SingleTickerProviderStateMixin {
  var _isOpened = false;
  AnimationController _animationController;
  Animation<Matrix4> _transformAnimation;
  Orientation _orientation;

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
            begin: Matrix4.identity()..scale(0.01, 0.01),
            end: Matrix4.identity(),
          ),
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orientation = MediaQuery.of(context).orientation;
    if (_orientation != null && _orientation != orientation) {
      _close();
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
    return PortalEntry(
      visible: _isOpened,
      portal: GestureDetector(
        onTapDown: (_) => _close(),
      ),
      child: PortalEntry(
        visible: _isOpened,
        childAnchor: Alignment.bottomRight,
        portalAnchor: const Alignment(1.05, -0.95),
        portal: AnimatedBuilder(
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
                  color: Colors.black.withOpacity(0.17),
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
                        child: action.child,
                        isDefaultAction: action.isDefaultAction,
                        isDestructiveAction: action.isDestructiveAction,
                        onPressed: () {
                          _close();
                          action.onPressed();
                        },
                        trailingIcon: action.trailingIcon,
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

class CupertinoPopupMenuButtonAction {
  const CupertinoPopupMenuButtonAction({
    @required this.child,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    this.trailingIcon,
  });

  final Widget child;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final VoidCallback onPressed;
  final IconData trailingIcon;
}
