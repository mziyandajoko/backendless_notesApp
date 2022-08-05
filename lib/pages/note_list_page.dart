import 'package:assignment2_2022/services/helper_service.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:assignment2_2022/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../routes/route_manager.dart';
import '../services/locator_service.dart';
import '../services/navigation_and_dialog_service.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //log user out
              logoutUserInUI(context);
            },
            icon: const Icon(Icons.lock),
          ),
          IconButton(
            onPressed: () {
              locator
                  .get<NavigationAndDialogService>()
                  .navigateTo(RouteManager.noteCreatePage);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text('List of Notes'),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: const Text('Title'),
              );
            },
          ),
          Selector<UserService, Tuple2>(
            selector: (context, value) =>
                Tuple2(value.showUserProgress, value.userProgressText),
            builder: (context, value, child) {
              return value.item1
                  ? AppProgressIndicator(text: '${value.item2}')
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
