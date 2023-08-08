import 'package:get/get.dart';
import 'package:hotsale_test/data/repository/repository.dart';
import 'package:hotsale_test/domain/user_details_model.dart';

class UserDetailsController extends GetxController {
  UserDetailsController({this.userId});

  final int? userId;

  Repository repository = Repository();

  UserDetailsModel? userDetailsModel;

  final isLoading = false.obs;

  @override
  onInit() {
    getUserInfo();
    super.onInit();
  }

  getUserInfo() async {
    isLoading(true);
    userDetailsModel = await repository.getUserInfo(userId!);
    isLoading(false);
  }
}