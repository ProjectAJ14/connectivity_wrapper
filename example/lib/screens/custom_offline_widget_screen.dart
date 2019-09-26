import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomOfflineWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.example2),
      ),
      body: ConnectivityWidgetWrapper(
        disableInteraction: true,
        offlineWidget: OfflineWidget(),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image(
            height: 300,
            image: AssetImage('assets/dog.gif'),
          ),
          Padding5(),
          Center(
            child: Text(
              Strings.offlineMessage,
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          Padding5(),
        ],
      ),
    );
  }
}
