import 'package:connectivity_wrapper/src/providers/connectivity_provider.dart';
import 'package:connectivity_wrapper/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectivityWidgetWrapper extends StatelessWidget {
  /// The [child] contained by the ConnectivityWidgetWrapper.
  final Widget child;

  /// The [offlineWidget] contained by the ConnectivityWidgetWrapper.
  final Widget offlineWidget;

  /// The decoration to paint behind the [child].
  final Decoration decoration;

  /// The decoration to paint behind the [child].
  final Decoration disableDecoration;

  /// Disconnected message.
  final String message;

  /// If non-null, the style to use for this text.
  final TextStyle messageStyle;

  /// widget height.
  final double height;

  /// widget height.
  final bool stacked;

  /// w.
  final bool disableInteraction;

  /// How to align the offline widget.

  final AlignmentGeometry alignment;

  const ConnectivityWidgetWrapper({
    Key key,
    this.child,
    this.decoration,
    this.message,
    this.messageStyle,
    this.height,
    this.offlineWidget,
    this.stacked = true,
    this.alignment,
    this.disableInteraction = false,
    this.disableDecoration,
  })  : assert(
          decoration == null || offlineWidget == null,
          'Cannot provide both a color and a offlineWidget\n',
        ),
        assert(
          height == null || offlineWidget == null,
          'Cannot provide both a height and a offlineWidget\n',
        ),
        assert(
          messageStyle == null || offlineWidget == null,
          'Cannot provide both a messageStyle and a offlineWidget\n',
        ),
        assert(
          message == null || offlineWidget == null,
          'Cannot provide both a message and a offlineWidget\n',
        ),
        assert(
          alignment == null || offlineWidget == null,
          'Cannot provide both a alignment and a offlineWidget\n',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = Provider.of<ConnectivityStatus>(context);
    var finalOfflineWidget = offlineWidget ??
        Align(
          alignment: alignment ?? Alignment.bottomCenter,
          child: Container(
            height: height ?? defaultHeight,
            width: MediaQuery.of(context).size.width,
            decoration: decoration ?? BoxDecoration(color: Colors.red.shade300),
            child: Center(
              child: Text(
                message ?? disconnectedMessage,
                style: messageStyle ?? defaultMessageStyle,
              ),
            ),
          ),
        );

    if (stacked)
      return Stack(
        children: <Widget>[
          child,
          disableInteraction && connectivityStatus != ConnectivityStatus.Connected
              ? Column(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        decoration: disableDecoration ??
                            BoxDecoration(
                              color: Colors.black38,
                            ),
                      ),
                    )
                  ],
                )
              : C0(),
          connectivityStatus != ConnectivityStatus.Connected ? finalOfflineWidget : C0(),
        ],
      );

    return connectivityStatus != ConnectivityStatus.Connected ? finalOfflineWidget : child;
  }
}

class C0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }
}
