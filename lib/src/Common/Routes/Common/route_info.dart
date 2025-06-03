import 'package:flutter/material.dart';

@protected
class RouteInfo {
  late String title;
  late String path;
  late String menuCode;
  late Widget page;

  RouteInfo({
    required this.title,
    required this.path,
    required this.menuCode,
    required this.page,
  });
}
