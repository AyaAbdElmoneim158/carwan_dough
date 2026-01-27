import 'package:carwan_dough/models/menu_model.dart';
import 'package:carwan_dough/utils/api_path.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';

abstract class HomeServices {
  Future<List<MenuModel>> fetchMenu();
  Future<void> addMenu(MenuModel menu);
  // Future<void> addItemToMenu();
}

class HomeServicesImpl implements HomeServices {
  final _firestore = FirestoreHelper.instance;

  @override
  Future<List<MenuModel>> fetchMenu() {
    final menu = _firestore.getCollection(
      path: ApiPath.menu,
      builder: (data, documentId) => MenuModel.fromMap(data),
    );
    return menu;
  } // Todo: Handle local

  @override
  Future<void> addMenu(MenuModel menu) async {
    await _firestore.setData(
      path: "Menu/${menu.id}",
      data: menu.toMap(),
    );
  }
}
/*
 await _firestore.setData(
      path: ApiPath.users(user.uid),
      data: user.toMap(),
    );
 */
