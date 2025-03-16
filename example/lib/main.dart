// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:printer_helper_v2/printer_helper_v2.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _platformVersion = 'Unknown';
//   final _printerHelperV2Plugin = PrinterHelperV2();

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       platformVersion =
//           await _printerHelperV2Plugin.getPlatformVersion() ?? 'Unknown platform version';
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Text('Running on: $_platformVersion\n'),
//         ),
//       ),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printer_helper_v2/printer_helper_v2.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  String resCheck = "connecting";
  String resCheckV2 = "connecting";
  String resCheckZQ = "connecting";
  ScreenshotController screenshotController = ScreenshotController();

  void testconnect() async {
    final printer = Pr3ConnectPrinter();

    final res = await printer.connectBluetooth("0C:A6:94:3A:1F:F5");
    setState(() {
      resCheck = res.toString();
    });

    if (res) {
      late Uint8List bytes;
      var widget = widgetTest();

      if (!mounted) return;
      await screenshotController
          .captureFromWidget(
        InheritedTheme.captureAll(
          context,
          Material(
            child: widget,
          ),
        ),
        context: context,
      )
          .then((capturedImage) {
        bytes = capturedImage;
      });

      await printer.image(bytes);

      setState(() {
        resCheck = "connecting";
      });
    }
  }

  void testconnectSunmi() async {
    final printer = SunmiV2connect();

    final res = await printer.connectBT("00:11:22:33:44:55");
    setState(() {
      resCheckV2 = res.toString();
    });

    late Uint8List bytes;
    var widget = widgetTest();

    if (!mounted) return;
    await screenshotController
        .captureFromWidget(
      InheritedTheme.captureAll(
        context,
        Material(
          child: widget,
        ),
      ),
      context: context,
    )
        .then((capturedImage) {
      bytes = capturedImage;
    });

    await printer.image(bytes);
  }

  void testconnectZQ320() async {
    final printer = Zq320ConnectPrinter();

    final res = await printer.connectBluetooth("58:93:D8:30:58:55");
    setState(() {
      resCheckZQ = res.toString();
    });

    late Uint8List bytes;
    var widget = widgetTest();

    if (!mounted) return;
    await screenshotController
        .captureFromWidget(
      InheritedTheme.captureAll(
        context,
        Material(
          child: widget,
        ),
      ),
      context: context,
    )
        .then((capturedImage) {
      bytes = capturedImage;
    });

    printer.image(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Text('intermec pr3: $resCheck\n'),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          testconnect();
                        },
                        child: const Text("connect ")),
                    ElevatedButton(
                        onPressed: () async {
                          await Pr3ConnectPrinter().disconnect();

                          setState(() {
                            resCheck = "connecting";
                          });
                        },
                        child: const Text("disconnect "))
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text('sunmi v2: $resCheckV2\n'),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          testconnectSunmi();
                        },
                        child: const Text("connect ")),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiV2connect().disconnect();

                          setState(() {
                            resCheckV2 = "connecting";
                          });
                        },
                        child: const Text("disconnect "))
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text('ZQ320: $resCheckZQ\n'),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          testconnectZQ320();
                        },
                        child: const Text("connect ")),
                    ElevatedButton(
                        onPressed: () async {
                          await Zq320ConnectPrinter().disconnect();

                          setState(() {
                            resCheckZQ = "connecting";
                          });
                        },
                        child: const Text("disconnect "))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget widgetTest() {
    // return Text("data");
    return SizedBox(
      width: 190,
      // height: 100,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Text(
            "${index + 1}  Test Print",
            style: const TextStyle(fontSize: 22),
          );
        },
      ),
    );
  }
}
