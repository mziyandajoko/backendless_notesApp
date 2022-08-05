import 'package:assignment2_2022/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../widgets/app_progress_indicator.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register User'),
        ),
        body: Stack(
          children: [
            Column(
              children: const  [
                Center(child: SingleChildScrollView(child: RegisterForm(),
                ),
                ),
              ],
            ),
                Selector<UserService, bool>(
                selector: (context, value) => value.userExists,
                builder: (context, value, child){
                return value ? Text('User already exists', style: TextStyle(color: Colors.red),) : Container();
                },
                ),
                Selector<UserService, Tuple2>(
                selector: (context, value, ) => Tuple2(value.showUserProgress, value.userProgressText),
                builder: (context, value, child){
                return value.item1 ? AppProgressIndicator(text: '${value.item2}') : Container();
                },
    ),
          ],
        ),
    );
  }
}
