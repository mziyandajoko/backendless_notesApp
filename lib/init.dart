import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

class InitApp {
  static const String apiKeyAndroid = '83986993-964D-452B-9734-C67B4CCD54BC';
  static const String apiKeyIOS = 'D3688F14-D8AF-4BC3-B430-EE18D3CFE0BE';
  static const String appID = 'BB7B4A80-A10F-D7CA-FF30-E7D44DB19100';

  static void initializeApp(context) async {
    try {
      try {
        await Backendless.setUrl("https://api.backendless.com");
        await Backendless.initApp(
          androidApiKey: apiKeyAndroid,
          iosApiKey: apiKeyIOS,
          applicationId: appID,
          jsApiKey: 'CCF90DBF-4769-4B6B-9441-2054DC4DBCC7',
          customDomain: 'https://api.backendless.com',
        );
      } catch (e) {
        print('failed $e');
      }
    } catch (e) {
      print('failed $e');
    }
  }
}
