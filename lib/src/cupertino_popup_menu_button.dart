import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class CupertinoPopupMenuButton extends StatefulWidget {
  const CupertinoPopupMenuButton({
    Key key,
    @required this.actions,
  }) : super(key: key);

  final List<CupertinoContextMenuAction> actions;

  @override
  _CupertinoPopupMenuButtonState createState() =>
      _CupertinoPopupMenuButtonState();
}

class _CupertinoPopupMenuButtonState extends State<CupertinoPopupMenuButton>
    with SingleTickerProviderStateMixin {
  var _isOpened = false;
  AnimationController _animationController;
  Animation<Matrix4> _transformAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
    )..addListener(() {
        if (_animationController.isDismissed) {
          setState(() {
            _isOpened = false;
          });
        }
      });

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
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalEntry(
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.17),
                blurRadius: 80,
                spreadRadius: 10,
              ),
            ],
          ),
          width: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions,
            ),
          ),
        ),
      ),
      child: IconButton(
        icon: const Icon(CupertinoIcons.ellipsis),
        onPressed: () {
          setState(() {
            if (_animationController.isCompleted) {
              _animationController
                ..duration = const Duration(milliseconds: 200)
                ..reverse();
            } else {
              setState(() {
                _isOpened = true;
              });
              _animationController
                ..duration = const Duration(milliseconds: 300)
                ..forward();
            }
          });
        },
      ),
    );
  }
}