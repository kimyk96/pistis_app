// Define a GoRouter provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pistis_app/src/Common/Routes/Common/routers.dart';

GoRouter route = Routers().getRoutes();
final goRouterProvider = Provider<GoRouter>((ref) {
  return route;
});
