import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voice_mate/src/repository/recording_repository.dart';
import 'package:voice_mate/src/util/router/route_names.dart';
import 'package:voice_mate/src/view/base_view.dart';
import 'package:voice_mate/src/view/shared_recordings/shared_recordings_view_model.dart';

class SharedRecordingsView extends StatefulWidget {
  const SharedRecordingsView({super.key});

  @override
  State<SharedRecordingsView> createState() => _SharedRecordingsViewState();
}

class _SharedRecordingsViewState extends State<SharedRecordingsView> {
  late final SharedRecordingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SharedRecordingsViewModel(
      repository: context.read<RecordingRepository>(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _viewModel.loadRecordings();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SharedRecordingsViewModel>(
      viewModel: _viewModel,
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('공유된 음성메시지'),
          ),
          body: viewModel.recordings.isEmpty
              ? const Center(
                  child: Text(
                    '공유된 음성메시지가 없습니다',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  itemCount: viewModel.recordings.length,
                  itemBuilder: (context, index) {
                    final recording = viewModel.recordings[index];
                    final replies = viewModel.repliesMap[recording.id] ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 원본 메시지
                        ListTile(
                          title: Text('사용자 ${recording.userId}'),
                          subtitle: Text(recording.timestamp.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.reply),
                            onPressed: () {
                              context.goNamed(
                                RouteNames.recording,
                                extra: {
                                  'originalRecordingId': recording.id,
                                  'targetNickname': recording.userId,
                                },
                              );
                            },
                          ),
                        ),
                        // 답장 목록
                        if (replies.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 48.w),
                            child: Column(
                              children: replies.map((reply) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.subdirectory_arrow_right,
                                    size: 20,
                                  ),
                                  title: Text('${reply.userId}의 답장'),
                                  subtitle: Text(
                                    reply.timestamp.toString(),
                                  ),
                                  dense: true,
                                );
                              }).toList(),
                            ),
                          ),
                        const Divider(),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}
