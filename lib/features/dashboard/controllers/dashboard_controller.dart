
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion24_deliveryman/features/chat/screens/conversation_screen.dart';
import 'package:fashion24_deliveryman/features/home/screens/home_screen.dart';
import 'package:fashion24_deliveryman/features/notification/screens/notification_screen.dart';
import 'package:fashion24_deliveryman/features/order/screens/order_history_screen.dart';
import 'package:fashion24_deliveryman/features/profile/screens/profile_screen.dart';

class DashboardController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  late List<Widget> screen;
  Widget? _currentScreen;
  Widget? get currentScreen => _currentScreen;
  DashboardController() {
    initPage();
  }


  selectHomePage({bool first = true}) {
    _currentScreen = screen[0];
    _currentTab = 0;
    if(first){
      update();
    }

  }

  void initPage() {
    screen = [
      HomeScreen(onTap: (int index) {
        _currentTab = index;
        update();
      }),
      const OrderHistoryScreen(fromMenu: true),
      const ConversationScreen(fromNotification: false),
      const NotificationScreen(fromNotification: false),
      const ProfileScreen(),
    ];
    _currentScreen = screen[0];
  }

  selectOrderHistoryScreen({bool fromHome =  false}) {
    _currentScreen = const OrderHistoryScreen();
    _currentTab = 1;
    update();

  }

  selectConversationScreen({bool isUpdate = true, int? chatIndex}) {
    _currentScreen = ConversationScreen(fromNotification: !isUpdate, chatIndex: chatIndex);
    print('====ChatIndex====>>${chatIndex}');
    _currentTab = 2;
    if(isUpdate){
      update();
    }
  }

  selectNotificationScreen({bool isUpdate = true}) {
    _currentScreen = NotificationScreen(fromNotification: !isUpdate);
    _currentTab = 3;
    if(isUpdate) {
      update();
    }
  }
  selectProfileScreen() {
    _currentScreen = const ProfileScreen();
    _currentTab = 4;
    update();
  }
}
