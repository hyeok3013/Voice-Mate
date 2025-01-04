import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voice_mate/src/repository/recording_repository.dart';
import 'package:voice_mate/src/util/router/route_names.dart';
import 'package:voice_mate/src/view/base_view.dart';
import 'package:voice_mate/src/view/recording/recording_view_model.dart';

class RecordingView extends StatefulWidget {
  final String? originalRecordingId;
  final String? targetNickname;

  const RecordingView({
    super.key,
    this.originalRecordingId,
    this.targetNickname,
  });

  @override
  State<RecordingView> createState() => _RecordingViewState();
}

class _RecordingViewState extends State<RecordingView> {
  late final RecordingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RecordingViewModel(
      repository: context.read<RecordingRepository>(),
    );

    if (widget.originalRecordingId != null) {
      _viewModel.setReplyMode(
        widget.originalRecordingId!,
        widget.targetNickname!,
      );
    }

    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    try {
      await _viewModel.initRecorder();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // @override
  // void dispose() {
  //   _viewModel.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BaseView<RecordingViewModel>(
      viewModel: _viewModel,
      builder: (context, viewModel) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2C1E40),
                  Color(0xFF1C1C1E),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    // 상단 상태 영역
                    Column(
                      children: [
                        Text(
                          viewModel.isRecording ? '녹음중...' : '녹음 준비중...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          viewModel.targetNickname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    // 하단 버튼 영역
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildPlayButton(viewModel),
                              SizedBox(width: 10.w),
                              _buildActionButton(Icons.tune, '필터', () {}),
                              SizedBox(width: 10.w),
                              _buildActionButton(Icons.list, '목록', () {
                                context.goNamed(RouteNames.sharedRecordings);
                              }),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(Icons.close, '취소', () {
                                viewModel.resetTarget();
                              }),
                              SizedBox(width: 10.w),
                              _buildRecordButton(viewModel),
                              SizedBox(width: 10.w),
                              _buildActionButton(Icons.send, '전송', () {
                                viewModel.uploadRecording();
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecordButton(RecordingViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        if (viewModel.isRecording) {
          await viewModel.stopRecording();
        } else {
          await viewModel.startRecording();
        }
      },
      child: Column(
        children: [
          Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: viewModel.isRecording ? Colors.white : Colors.red,
            ),
            child: Icon(
              viewModel.isRecording ? Icons.stop : Icons.mic,
              color: viewModel.isRecording ? Colors.red : Colors.white,
              size: 36.w,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            viewModel.isRecording ? '중지' : '녹음',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayButton(RecordingViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        try {
          await viewModel.playRecording();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
      },
      child: Column(
        children: [
          Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: viewModel.isPlaying
                  ? Colors.white.withOpacity(0.4) // 재생 중일 때 더 밝은 배경
                  : Colors.white.withOpacity(0.2),
            ),
            child: Icon(
              // 재생 상태에 따라 아이콘 변경
              viewModel.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 36.w,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            // 상태에 따라 텍스트 변경
            viewModel.isPlaying ? '일시정지' : '재생',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 36.w,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}
