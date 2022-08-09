import 'package:assignment2_2022/init.dart';
import 'package:assignment2_2022/pages/login_page.dart';
import 'package:assignment2_2022/pages/note_list_page.dart';
import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/user_service.dart';
import '../widgets/app_progress_indicator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserService>().currentUser;

    // To S

    if (currentUser == null) {
      return LoginPage();
    } else {
      return NoteListPage();
    }

    // return const Scaffold(
    //   body: AppProgressIndicator(
    //       text: 'Busy checking credentials...please wait...'),
    // );
  }
}
