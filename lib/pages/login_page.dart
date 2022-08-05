import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../services/user_service.dart';
import '../widgets/app_progress_indicator.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login User'),
      ),
      body: Stack(
        children: [
          Column(
            children: const [
              Center(child: SingleChildScrollView(child: LoginForm())),
            ],
          ),
        // Selector<UserService, Tuple2>(selector: (context, value) => Tuple2(value.showUserProgress, value.userProgressText),
        //   builder: (context, value, child) {
        //   return value.item1 ? AppProgressIndicator(text: '${value.item2}'):Container();
        // },),
        ],
      ),
    );
  }
}
