import 'package:get/get.dart';
import 'package:hotsale_test/data/repository/repository.dart';
import 'package:hotsale_test/domain/user_list_model.dart';

class UserListController extends GetxController {

  Repository repository = Repository();

  final _users = <DatumModel>[].obs;
  final _lastPage = false.obs;
  final isDataLoading = false.obs;

  List<DatumModel> get users => _users.toList();
  bool get lastPage => _lastPage.value;

  @override
  void onInit() {
    getAllUsers(1);
    super.onInit();
  }

  Future<void> getAllUsers(int page) async {
    final userModel = await repository.getListUsers(page);
    if (userModel != null) {
      if (userModel.data.length + _users.length >= 12) {
        _lastPage.value = true;
      }
      _users.addAll(userModel.data);
    }
  }
}
