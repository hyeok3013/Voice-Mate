import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_mate/src/util/router/route_names.dart';
import 'package:voice_mate/src/view/recording/recording_view.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: rootNavigatorKey, // navigatorKey 설정
  initialLocation: '/recording',
  routes: [
    GoRoute(
      path: '/recording',
      name: RouteNames.recording,
      builder: (BuildContext context, GoRouterState state) {
        return RecordingView();
      },
    ),
  ],
);
