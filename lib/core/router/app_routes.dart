abstract final class AppRoutes {
  static const splash = '/';
  static const products = '/products';

  static String productDetails(int id) => '/products/$id';
}
