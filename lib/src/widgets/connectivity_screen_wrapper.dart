// Flutter imports:

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper/src/utils/constants.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';

enum PositionOnScreen {
  TOP,
  BOTTOM,
}

class ConnectivityScreenWrapper extends StatelessWidget {
  /// The [child] contained by the ConnectivityScreenWrapper.
  final Widget? child;

  /// The decoration to paint behind the [child].
  final Decoration? decoration;

  /// The color to paint behind the [child].
  final Color? color;

  /// Disconnected message.
  final String? message;

  /// If non-null, the style to use for this text.
  final TextStyle? messageStyle;

  /// widget height.
  final double? height;

  /// How to align the offline widget.
  final PositionOnScreen positionOnScreen;

  /// How to align the offline widget.
  final Duration? duration;

  /// Disable the user interaction with child widget
  final bool disableInteraction;

  /// Disable the user interaction with child widget
  final Widget? disableWidget;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  const ConnectivityScreenWrapper({
    Key? key,
    this.child,
    this.color,
    this.decoration,
    this.message,
    this.messageStyle,
    this.height,
    this.textAlign,
    this.duration,
    this.positionOnScreen = PositionOnScreen.BOTTOM,
    this.disableInteraction = false,
    this.disableWidget,
  })  : assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOffline = Provider.of<ConnectivityStatus>(context) !=
        ConnectivityStatus.CONNECTED;

    double _height = height ?? defaultHeight;

    final Widget _offlineWidget = AnimatedPositioned(
      top: positionOnScreen.top(_height, isOffline),
      bottom: positionOnScreen.bottom(_height, isOffline),
      child: AnimatedContainer(
        height: _height,
        width: MediaQuery.of(context).size.width,
        decoration:
            decoration ?? BoxDecoration(color: color ?? Colors.red.shade500),
        child: Center(
          child: Text(
            message ?? disconnectedMessage,
            style: messageStyle ?? defaultMessageStyle,
            textAlign: textAlign,
          ),
        ),
        duration: duration ?? Duration(milliseconds: 300),
      ),
      duration: duration ?? Duration(milliseconds: 300),
    );

    return AbsorbPointer(
      absorbing: (disableInteraction && isOffline),
      child: Stack(
        children: [
          if (child != null) child!,
          if (disableInteraction && isOffline)
            if (disableWidget != null) disableWidget!,
          _offlineWidget,
        ],
      ),
    );
  }
}
