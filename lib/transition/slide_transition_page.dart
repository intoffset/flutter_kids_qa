import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideTransitionPage extends CustomTransitionPage {
  SlideTransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: transitionBuilder,
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
        );

  static get transitionBuilder =>
      (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return _SlideEnterTransition(
          animation: animation,
          child: _SlideExitTransition(
            animation: secondaryAnimation,
            child: child,
          ),
        );
      };
}

class _SlideEnterTransition extends SlideTransition {
  _SlideEnterTransition({super.key, required super.child, required Animation<double> animation})
      : super(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        );
}

class _SlideExitTransition extends SlideTransition {
  _SlideExitTransition({super.key, required super.child, required Animation<double> animation})
      : super(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-0.1, 0.0),
          ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        );
}
