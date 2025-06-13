import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api/apis.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:platform/platform.dart';


class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permission for iOS
    listenForTokenRefresh();

    NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get the token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // const InitializationSettings initializationSettings =
    //     InitializationSettings(android: initializationSettingsAndroid);

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
    );
    
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Handle when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message);
    });

    // Handle notification when the app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationClick(initialMessage);
    }
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'sports_carnival_channel',
      'Sports Carnival Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['route'],
    );
  }

  static void _handleNotificationClick(RemoteMessage message) {
    // You can navigate to specific screens based on the notification data
    String? route = message.data['route'];
    print("Notification clicked with route: $route");
    // Add your navigation logic here
  }

  static void listenForTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print("FCM Token refreshed: $newToken");
      await sendTokenToServer(newToken);
    });
  }

  static Future<String?> getFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }

  static Future<void> sendTokenToServer(String? token) async {
    if (token == null) return;

final deviceInfo = await getDeviceInfo();
    try {
      final response = await http.post(
        Uri.parse(Apis.fetchBannerFCMDetails),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'registrationid': token,
          'devicetype': deviceInfo['device_type'], // or 'ios'
          'deviceid': deviceInfo['device_id'], // optional
        }),
      );

      if (response.statusCode == 200) {
        print('Token successfully sent to server');
      } else {
        print('Failed to send token to server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }

static Future<Map<String, dynamic>> getDeviceInfo() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceType = 'unknown';
  String? deviceId;

  try {
    if (const LocalPlatform().isAndroid) {
      deviceType = 'android';
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // OR use androidInfo.androidId for Android ID
    } else if (const LocalPlatform().isIOS) {
      deviceType = 'ios';
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
  } catch (e) {
    print('Error getting device info: $e');
    deviceId = const Uuid().v4(); // Fallback UUID
  }

  return {
    'device_type': deviceType,
    'device_id': deviceId ?? const Uuid().v4(), // Final fallback
  };
}

}