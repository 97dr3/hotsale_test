import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotsale_test/ui/user_details/user_details_page.dart';
import 'package:hotsale_test/ui/user_list/user_list_controller.dart';
import 'package:image_network/image_network.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final dataController = Get.put(
    UserListController(),
  );
  var _loadMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: Obx(
        () {
          final length = dataController.users.length > 12
              ? 12
              : dataController.users.length;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: NotificationListener<ScrollNotification>(
              onNotification: _notificationListener,
              child: ListView.builder(
                itemCount: dataController.users.length > 12
                    ? 12
                    : dataController.users.length,
                itemBuilder: (context, index) {
                  if (index == length - 1 && !dataController.lastPage) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsPage(
                            userId: dataController.users[index].id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.lightBlueAccent,
                      width: 200,
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ImageNetwork(
                                image: dataController.users[index].avatar,
                                height: 100.0,
                                width: 100.0,
                                onError: const SizedBox(),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${dataController.users[index].firstName}"),
                              Text("Email: ${dataController.users[index].email}"),
                              Text("User ID: ${dataController.users[index].id}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  bool _notificationListener(ScrollNotification notification) {
    if (dataController.lastPage) {
      return false;
    }
    if (notification.metrics.pixels > notification.metrics.maxScrollExtent * 0.7 && _loadMore) {
      _loadMore = false;
      dataController.getAllUsers(2);
      Future<void>.delayed(
        const Duration(seconds: 1),
        () => _loadMore = true,
      );
    }
    return false;
  }
}
