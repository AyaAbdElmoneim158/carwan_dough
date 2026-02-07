import 'package:carwan_dough/models/menu_model.dart';
import 'package:carwan_dough/utils/api_path.dart';
import 'package:carwan_dough/utils/helper/app_cache.dart';
import 'package:carwan_dough/utils/helper/connectivity_service.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';

abstract class HomeServices {
  Future<List<MenuModel>> fetchMenu();
  //? Admin_operations
  // Future<void> addMenu(MenuModel menu);
  // Future<void> addItemToMenu();
}

class HomeServicesImpl implements HomeServices {
  final _firestore = FirestoreHelper.instance;
  final connectivity = ConnectivityService.instance;
  @override
  Future<List<MenuModel>> fetchMenu() async {
    List<MenuModel> menu = [];
    if (!connectivity.isConnected.value) {
      menu = await AppCache.getMenu();
    } else {
      menu = await _firestore.getCollection(
        path: ApiPath.menu,
        builder: (data, documentId) => MenuModel.fromMap(data),
      );
      await AppCache.saveProducts(menu);
    }
    return menu;
  }

  // @override
  // Future<void> addMenu(MenuModel menu) async {
  //   await _firestore.setData(
  //     path: "Menu/${menu.id}",
  //     data: menu.toMap(),
  //   );
  // }
}
/*
 await _firestore.setData(
      path: ApiPath.users(user.uid),
      data: user.toMap(),
    );
 */
