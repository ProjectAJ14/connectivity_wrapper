# connectivity_wrapper

This plugin allows Flutter apps provide feedback on your app when it's not connected to it, or when there's no connection.

## Usage

**STEP 1: Add the package to `pubspec.yaml`
**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2
  connectivity_wrapper: 0.0.1
```

**STEP 2: Import the package to main.dart
**
```dart
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
```
**STEP 3: Wrap `MaterialApp/CupertinoApp` with `ConnectivityAppWrapper`
**
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        title: 'Connectivity Wrapper Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MenuScreen(),
      ),
    );
  }
}
```

**STEP 4: The last step, Wrap your body widget with `ConnectivityWidgetWrapper`
**
```dart

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connectivity Wrapper Example"),
      ),
      body: ConnectivityWidgetWrapper(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(Strings.example1),
              onTap: () {
                AppRoutes.push(context, ScaffoldExampleScreen());
              },
            ),
            Divider(),
            ListTile(
              title: Text(Strings.example2),
              onTap: () {
                AppRoutes.push(context, CustomOfflineWidgetScreen());
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
```

[[1]][1]



> Note that you should not be using the current network status for deciding
whether you can reliably make a network connection. Always guard your app code
against timeouts and errors that might come from the network layer.
[1]: http://https://medium.com "Checkout this story for more examples"

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
