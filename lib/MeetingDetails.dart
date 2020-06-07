import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'Login.dart';

class ServerSett extends StatefulWidget {
  @override
  _ServerSettState createState() => _ServerSettState();
}

class _ServerSettState extends State<ServerSett> {
  final serverText = TextEditingController();
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    // change the name as you like cuz this page cannot be a login page
                    child: Text('Room Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                  Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 65.0,),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 83.0,
                            height: 1.5,
                            color: Colors.black,            
                          ),
                        ),
                      ),
                SizedBox(
                  height: 55.0,
                ),
                TextField(
                  controller: roomText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Room",
                    hintText: "Enter the Room Name",

                  ),
                ),
                SizedBox(
                  height: 26.0,
                ),
                TextField(
                  controller: subjectText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Subject",
                    hintText: "Enter the subject",
                  ),
                ),
                SizedBox(
                  height: 26.0,
                ),
                TextField(
                        controller: serverText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Server URL",
                          hintText: "Enter the server URL (optional)",
                        ),
                        
                      ),
                SizedBox(
                  height: 32.0,
                ),
                CheckboxListTile(
                  title: Text("Audio Only"),
                  value: isAudioOnly,
                  onChanged: _onAudioOnlyChanged,
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                ),
                SizedBox(
                  height: 8.0,
                ),
                CheckboxListTile(
                  title: Text("Audio Muted"),
                  value: isAudioMuted,
                  onChanged: _onAudioMutedChanged,
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                ),
                SizedBox(
                  height: 8.0,
                ),
                CheckboxListTile(
                  title: Text("Video Muted"),
                  value: isVideoMuted,
                  onChanged: _onVideoMutedChanged,
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                ),
                SizedBox(
                  height: 22.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50),
                  child: SizedBox(
                    height: 64.0,
                    width: double.maxFinite,
                    child:Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5,),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () {
                        _joinMeeting();
                      },
                      child: Text(
                        "Create Meeting",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                      ),
                      color: Colors.black,
                    ),
                    ),
                  ),
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
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(options,
          listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
            debugPrint("${options.room} will join with message: $message");
          }, onConferenceJoined: ({message}) {
            debugPrint("${options.room} joined with message: $message");
          }, onConferenceTerminated: ({message}) {
            debugPrint("${options.room} terminated with message: $message");
          }));
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
