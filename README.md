# connectivity_wrapper

This plugin allows Flutter apps provide feedback on your app when it's not connected to it, or when there's no connection.

## Usage

##STEP 1: Add the package to `pubspec.yaml`


```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2
  connectivity_wrapper: 1.0.2
```

##STEP 2: Import the package to main.dart


```dart
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
```
##STEP 3: Wrap `MaterialApp/CupertinoApp` with `ConnectivityAppWrapper`

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

##STEP 4: The last step, Wrap your body widget with `ConnectivityWidgetWrapper`

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

![](https://cdn-images-1.medium.com/max/800/1*0ClOpA0bDy57h8ib9XiqQg.gif)


## Also, you can customize the offlineWidget . Let's see few examples.


##Custom Decoration


```dart
....
body: ConnectivityWidgetWrapper(
  decoration: BoxDecoration(
    color: Colors.purple,
    gradient: new LinearGradient(
      colors: [Colors.red, Colors.cyan],
    ),
  ),
  child: ListView(
....
```

![](https://cdn-images-1.medium.com/max/600/1*qUAaseD03Jrk7I91LDv-sQ.png)


##Custom Height and Message


```dart
...
body: ConnectivityWidgetWrapper(
  decoration: BoxDecoration(
    color: Colors.purple,
    gradient: new LinearGradient(
      colors: [Colors.red, Colors.cyan],
    ),
  ),
  height: 150.0,
  message: "You are Offline!",
  messageStyle: TextStyle(
    color: Colors.white,
    fontSize: 40.0,
  ),
  child: ListView(
...
```

![](https://cdn-images-1.medium.com/max/600/1*OeVKSyfV2X9VhupXRdwb2g.png)

##Custom Alignment and Disable User Interaction
 

```dart
...
body: ConnectivityWidgetWrapper(
  alignment: Alignment.topCenter,
  disableInteraction: true,
  child: ListView(
...
```

![](https://cdn-images-1.medium.com/max/600/1*wHJXb7XqHizgEvZ-RjhsDA.gif)



##Provide your own Custom Offline Widget
 

```dart
...
body: ConnectivityWidgetWrapper(
  disableInteraction: true,
  offlineWidget: OfflineWidget(),
  child: ListView.builder(
....
```

![](https://cdn-images-1.medium.com/max/600/1*95pBwxafvlsDvcYIs9krJQ.gif)


##Convert Any widget to network-aware widget


Wrap the widget `RaisedButton` which you want to be network-aware with `ConnectivityWidgetWrapper` and set `stacked: false`.
Provide an `offlineWidget` to replace the current widget when the device is offline.

```dart
class NetworkAwareWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.example3),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          P5(),
          TextField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
          P5(),
          ConnectivityWidgetWrapper(
            stacked: false,
            offlineWidget: RaisedButton(
              onPressed: null,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Connecting",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    P5(),
                    CupertinoActivityIndicator(radius: 8.0),
                  ],
                ),
              ),
            ),
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
```

![](https://cdn-images-1.medium.com/max/800/1*Biyy0EnWf8yVeA40iJcKGQ.gif)




> Note that you should not be using the current network status for deciding
whether you can reliably make a network connection. Always guard your app code
against timeouts and errors that might come from the network layer.
 
## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
