import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'MeetingDetails.dart';

final nameText = TextEditingController(text: "Plugin Test User");
final emailText = TextEditingController(text: "fake@email.com");

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 1000), () {
          debugPrint('Splash Delay');
          return true;
        }),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Jitsi Flutter'),
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 24.0,
                      ),
                      TextField(
                        controller: nameText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Display Name",
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        controller: emailText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 64.0,
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ServerSett()));
                            },
                            child: Text(
                              "Save details and continue",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(
                      'lottie/loading.json',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Loading...',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
