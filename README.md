[![](https://img.shields.io/badge/build-1.1.4-brightgreen)](https://github.com/ProjectAj14/connectivity_wrapper)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# connectivity_wrapper

This plugin allows Flutter apps provide feedback on your app when it's not connected to it, or when there's no connection.

## Let's get started

1. Go to `pubspec.yaml` 
2. add a ns_utils and replace `[version]` with the latest version:  

```yaml
dependencies:
  flutter:
    sdk: flutter
  connectivity_wrapper: ^[version]
```
3. click the packages get button or *flutter pub get*  

## Import the package

```dart
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
```

##Check if device is connected to internet or not 

```dart
...

 onTap: () async {
        if (await ConnectivityWrapper.instance.isConnected) {
          showSnackBar(
            _scaffoldKey,
            title: "You Are Connected",
            color: Colors.green,
          );
        } else {
          showSnackBar(
            _scaffoldKey,
            title: "You Are Not Connected",
          );
        }
      },

...

```

##Create `Network` Aware Widgets

#Type 1: A common widget for the entire app

##STEP 1: Wrap `MaterialApp/CupertinoApp` with `ConnectivityAppWrapper`

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
        builder: (buildContext, widget) {
          return ConnectivityWidgetWrapper(
            child: widget,
            disableInteraction: true,
            height: 80,
          );
        },
      ),
    );
  }
}
```

#Type 2: Screen/widget specific widgets

##STEP 1: Wrap `MaterialApp/CupertinoApp` with `ConnectivityAppWrapper`

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


##STEP 2: The last step, Wrap your body widget with `ConnectivityWidgetWrapper` or use [`ConnectivityScreenWrapper`](https://github.com/ProjectAj14/connectivity_wrapper/blob/master/example/lib/screens/menu_screen.dart) for In-build animation

```dart

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connectivity Wrapper Example"),
      ),
      body: ConnectivityWidgetWrapper( // or use ##ConnectivityScreenWrapper for In build animation
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
 
 

## Contributing

There are couple of ways in which you can contribute.
- Propose any feature, enhancement
- Report a bug
- Fix a bug
- Participate in a discussion and help in decision making
- Write and improve some **documentation**. Documentation is super critical and its importance
  cannot be overstated!
- Send in a Pull Request :-)



<br>
<div align="center" >
  <p>Thanks to all contributors of this package</p>
  <a href="https://github.com/ProjectAJ14/connectivity_wrapper/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=ProjectAJ14/connectivity_wrapper" />
  </a>
</div>
<br>