import 'package:flutter/material.dart';
import 'package:pistis_app/src/Common/Routes/Common/route_info.dart';
import 'package:pistis_app/src/Pages/home/home_view.dart';

@protected
final List<RouteInfo> globalRoutes = [
  RouteInfo(
    title: "메인",
    path: '/',
    menuCode: "",
    page: const HomeView(),
  ),
];
