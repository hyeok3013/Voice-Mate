import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordingView extends StatelessWidget {
  const RecordingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black.withOpacity(0.95),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C1E40), // 어두운 보라
              Color(0xFF1C1C1E), // 거의 검정
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                // 상단 상태 영역
                Column(
                  children: [
                    Text(
                      '녹음 준비중...',
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

                // 중앙 타이머 영역
                Expanded(
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                // 하단 버튼 영역
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(Icons.play_arrow, '재생'),
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
                          _buildRecordButton(),
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

  Widget _buildRecordButton() {
    return Column(
      children: [
        Container(
          width: 78.w,
          height: 78.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Icon(
            Icons.mic,
            color: Colors.white,
            size: 36.w,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          '녹음',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}
