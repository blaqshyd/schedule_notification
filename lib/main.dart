import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'schedule.dart';
import 'package:schedule_notification/notification_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );
  await NotificationServices.initializeNotification();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController textEditingController = TextEditingController();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                  fontSize: 22,
                ),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Schedule Details ... ",
                  hintStyle: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                NotificationServices.scheduleNotification(
                  schedule: Schedule(
                    details: textEditingController.text.trim(),
                    time: now.add(
                      const Duration(seconds: 15),
                    ),
                  ),
                ).then(
                  (_) {
                    setState(() {
                      textEditingController.clear();
                    });
                  },
                );
              },
              child: const Text("SCHEDULE"),
            ),
          ],
        ),
      ),
    );
  }
}
