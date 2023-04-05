import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/ui_helper.dart' as ui_helper;
import 'package:flutter/material.dart';

class CustomOfflineWidgetScreen extends StatelessWidget {
  const CustomOfflineWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.example2),
      ),
      body: ConnectivityWidgetWrapper(
        disableInteraction: true,
        offlineWidget: const OfflineWidget(),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(" Item $index"),
            );
          },
        ),
      ),
    );
  }
}

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        Image(
          height: 300,
          image: AssetImage('assets/dog.gif'),
        ),
        ui_helper.Spacer(),
        Center(
          child: Text(
            Strings.offlineMessage,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        ui_helper.Spacer(),
      ],
    );
  }
}
