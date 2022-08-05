// ignore_for_file: use_build_context_synchronously

import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/note_service.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:assignment2_2022/widgets/snackBar.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String retypePassword}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || password.isEmpty || retypePassword.isEmpty) {
    showSnackBar(
      context,
      'Enter all fields!',
    );
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim()
      ..putProperties({
        'name': retypePassword.trim(),
      });

    String result = await context.read<UserService>().createUser(user);
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, 'New user successfully created!');
      Navigator.pop(context);
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Please enter both fields!');
  } else {
    String result = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      // fetching notes
      context.read<NoteService>().getNotes(email);
      // navigating to notelistpage
      Navigator.of(context).popAndPushNamed(RouteManager.noteListPage);
    }
  }
}

// reset password
void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context, 'Please enter your email address');
  } else {
    String result =
        await context.read<UserService>().resetPassword(email.trim());
    if (result == 'OK') {
      showSnackBar(context, 'Successfully sent password reset.');
    } else {
      showSnackBar(context, result);
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserService>().logoutUser();
  if (result == 'OK') {
    context.read<UserService>().setCurrentUserNull();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackBar(context, result);
  }
}
