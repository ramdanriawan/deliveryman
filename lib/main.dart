import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fashion24_deliveryman/features/notification/domain/models/notification_body.dart';
import 'package:fashion24_deliveryman/theme/dark_theme.dart';
import 'package:fashion24_deliveryman/theme/light_theme.dart';
import 'package:fashion24_deliveryman/utill/app_constants.dart';
import 'package:fashion24_deliveryman/utill/messages.dart';
import 'package:fashion24_deliveryman/features/splash/screens/splash_screen.dart';
import 'common/controllers/localization_controller.dart';
import 'features/splash/controllers/splash_controller.dart';
import 'theme/controllers/theme_controller.dart';
import 'helper/get_di.dart' as di;
import 'package:url_strategy/url_strategy.dart';
import 'helper/notification_helper.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
late AndroidNotificationChannel channel;

Future<void> main() async {
  try {
    HttpOverrides.global = MyHttpOverrides();

    setPathUrlStrategy();
    WidgetsFlutterBinding.ensureInitialized();
    if (Firebase.apps.isEmpty) {
      if (Platform.isAndroid) {
        await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: "AIzaSyCT2_b6tVvU6jGsXkgLA2Vgwcy2gVHaECk",
                projectId: "fashion24-delivery-man",
                messagingSenderId: "483446824756",
                appId: "1:483446824756:android:caf218be6b66de34708f61"),
            name: 'Delivery');
      } else {
        await Firebase.initializeApp(
            name: 'Delivery',
            options: const FirebaseOptions(
                apiKey: "AIzaSyDujL4SjWuFhrQvc1LQ2Dj2RS1BUZMxjq0",
                projectId: "fashion24-delivery-man",
                messagingSenderId: "483446824756",
                appId: "1:483446824756:ios:cc3dad85f609e26a708f61"));
      }
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      await FirebaseMessaging.instance.requestPermission();
    } else {
      await FirebaseMessaging.instance.requestPermission(provisional: true);
    }

    // _deleteCacheDir();
    // deleteAppDir();
    // FlutterNativeSplash.remove();
    Map<String, Map<String, String>> _languages = await di.init();

    //flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    NotificationBody? body;

    try {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
      );
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        body = NotificationBody.fromJson(remoteMessage.data);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } catch (_) {}

    // await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    // await Permission.notification.isDenied.then((value) {
    //   if (value) {
    //     Permission.notification.request();
    //   }
    // });

    // NotificationBody? body;
    // try {
    //   final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    //   if (remoteMessage != null) {
    //     body = NotificationBody.fromJson(remoteMessage.data);
    //   }
    // } catch(e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }

    runApp(MyApp(languages: _languages, body: body));
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final NotificationBody? body;

  const MyApp({Key? key, required this.languages, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return GetMaterialApp(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              theme: themeController.darkTheme ? dark : light,
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
                  AppConstants.languages[0].countryCode),
              home: SplashScreen(body: body),
              defaultTransition: Transition.topLevel,
              transitionDuration: const Duration(milliseconds: 500),
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.noScaling),
                    child: child!);
              });
        });
      });
    });
  }
}

Future<void> _deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<void> _deleteAppDir() async {
  final appDir = await getApplicationSupportDirectory();

  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
