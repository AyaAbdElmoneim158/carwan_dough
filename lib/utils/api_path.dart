class ApiPath {
  static String users(String uid) => "Users/$uid/";
  static const String menu = "Menu/";

  static String cart(String uid) => "Users/$uid/Cart/";
  static String cartWithId(String uid, String cartId) => "Users/$uid/Cart/$cartId";
}
