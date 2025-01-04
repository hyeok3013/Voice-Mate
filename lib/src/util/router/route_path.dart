import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_mate/src/util/router/route_names.dart';
import 'package:voice_mate/src/view/recording/recording_view.dart';
import 'package:voice_mate/src/view/shared_recordings/shared_recordings_view.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: rootNavigatorKey, // navigatorKey 설정
  initialLocation: '/recording',
  routes: [
    GoRoute(
      path: '/recording',
      name: RouteNames.recording,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>?;
        if (extra != null) {
          return RecordingView(
            originalRecordingId: extra['originalRecordingId'] as String,
            targetNickname: extra['targetNickname'] as String,
          );
        }
        return const RecordingView();
      },
    ),
    GoRoute(
      path: '/shared-recordings',
      name: RouteNames.sharedRecordings,
      builder: (BuildContext context, GoRouterState state) {
        return SharedRecordingsView();
      },
    ),
  ],
);
