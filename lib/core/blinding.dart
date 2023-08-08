import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:hotsale_test/ui/user_details/user_details_controller.dart';
import 'package:hotsale_test/ui/user_list/user_list_controller.dart';

class DependenciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserListController>(
          () => UserListController(),
    );
    Get.lazyPut<UserDetailsController>(
          () => UserDetailsController(),
    );
  }
}