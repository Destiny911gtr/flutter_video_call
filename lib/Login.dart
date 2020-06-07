import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'MeetingDetails.dart';

final nameText = TextEditingController();
final emailText = TextEditingController();

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
        future: Future.delayed(const Duration(milliseconds: 2000), () {
          debugPrint('Splash Delay');
          return true;
        }),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: kToolbarHeight,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0)
                          ,)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 110.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 38.0,
                            height: 1.5,
                            color: Colors.black,            
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120.0,
                      ),
                      TextField(
                        controller: nameText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                          hintText: "Enter Your name",
                        ),
                        
                      ),
                      SizedBox(
                        height: 26.0,
                      ),
                      TextField(
                        controller: emailText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "abc@xyz.com"
                        ),
                      ),
                      SizedBox(
                        height: 26.0,
                      ),
                      SizedBox(
                        height: 64.0,
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50, top: 5,bottom: 5,right: 50),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ServerSett()));
                            },
                            child: Text(
                              "Save details and continue",
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                            color: Colors.black,
                            elevation: 10.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      Padding(padding: const EdgeInsets.all(13),),
                    SizedBox(height: 183,),
                    Text(
                      'Powered by Jitsi.Meet',textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400]),
                    ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(0, 266, 0, 0),
                  children: <Widget>[
                    Lottie.asset(
                      'lottie/loading.json',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Loading...',textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    Padding(padding: const EdgeInsets.all(13),),
                    SizedBox(height: 278,),
                    Text(
                      'Powered by Jitsi.Meet',textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400]),
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
