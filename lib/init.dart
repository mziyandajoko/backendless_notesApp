import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

class InitApp {
  static const String apiKeyAndroid = '727B6DD1-EAC5-4E10-A5C7-FFA5DE2281D4';
  static const String apiKeyIOS = 'D1E82193-4971-4932-B727-5488EBE184B7';
  static const String appID = 'BB7B4A80-A10F-D7CA-FF30-E7D44DB19100';

  static void initializeApp(context) async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);

    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<UserService>()
          .getNotes(context.read<UserService>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.noteListPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
