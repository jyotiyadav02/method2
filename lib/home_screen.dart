import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testingnotification/notification_services.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NotificationServices notificationServices = NotificationServices();

  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.isRefreshToken();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value) {
      print("device token");
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          TextDirection.ltr, // or TextDirection.rtl for right-to-left
      child: Container(
        color: Colors.amberAccent,
        child: Center(
          child: TextButton(
            child: Text("Click here  to get notification without help of'\n  firebase sometimes it takes time  "),
            onPressed: () {
              notificationServices.getDeviceToken().then((value) async {
                var data = {
                  'to':value.toString(),
                  'priority': 'high',
                  'notification': {'title': 'Jyoti yadav task ', 'body': 'notification'},
                  'data':{
                    'type':'msj',
                    'id':'jyoti@124567890'
                  }
                };

                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization':
                          'key=AAAA_idDb8c:APA91bH00aQYl9DxnsrwYX5jMASKRMHtkZTU8CUZg5w-VugXApnqFG3zIV2iivjFraZl4HEbFVivAUKjMDoOdwKwzHAHW12KvFwjPNaeLmRybMkXcyE_wGENk99tTTO0Kv5TQ0ZIyPli',
                    });
              });
            },
          ),
        ),
      ),
    );
  }
}
