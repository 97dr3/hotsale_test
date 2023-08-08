import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotsale_test/core/network_controller.dart';
import 'package:hotsale_test/ui/user_details/user_details_controller.dart';
import 'package:image_network/image_network.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({
    super.key,
    required this.userId,
  });

  final int userId;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    UserDetailsController userDetailsController = Get.put(
      UserDetailsController(userId: widget.userId),
    );
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.delete<UserDetailsController>();
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_outlined),
        ),
        title: const Text("User Details"),
        centerTitle: true,
      ),
      body: Obx(
        () => userDetailsController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.lightBlueAccent,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageNetwork(
                      image: userDetailsController.userDetailsModel!.data.avatar,
                      height: 100.0,
                      width: 100.0,
                      onError: const SizedBox(),
                    ),
                    Text(
                      "support text: ${userDetailsController.userDetailsModel!.support.text}",
                    ),
                    Text(
                        "support url: ${userDetailsController.userDetailsModel!.support.url}"),
                  ],
                ),
              ),
      ),
    );
  }
}
