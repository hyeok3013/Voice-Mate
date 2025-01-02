import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_mate/src/view/base_view.dart';
import 'package:voice_mate/src/view/recording/recording_view_model.dart';

class RecordingView extends StatefulWidget {
  const RecordingView({super.key});

  @override
  State<RecordingView> createState() => _RecordingViewState();
}

class _RecordingViewState extends State<RecordingView> {
  late RecordingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RecordingViewModel();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    try {
      await _viewModel.initializeRecorder();
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

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

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
                          '춤추는바람-7942',
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
                              _buildActionButton(Icons.tune, '필터'),
                              SizedBox(width: 10.w),
                              _buildActionButton(Icons.mic_off, '음소거'),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(Icons.close, '취소'),
                              SizedBox(width: 10.w),
                              _buildRecordButton(viewModel),
                              SizedBox(width: 10.w),
                              _buildActionButton(Icons.send, '전송'),
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
        if (viewModel.isPlaying) {
          await viewModel.stopPlaying();
        } else {
          await viewModel.playRecording();
        }
      },
      child: Column(
        children: [
          Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(
              viewModel.isPlaying ? Icons.stop : Icons.play_arrow,
              color: Colors.white,
              size: 36.w,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            viewModel.isPlaying ? '중지' : '재생',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
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
