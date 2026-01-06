import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class IconSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const IconSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<IconSwitch> createState() => _IconSwitchState();
}

class _IconSwitchState extends State<IconSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.value;
  }

  void toggle() {
    if (kDebugMode) {
      print('IconSwitch tapped!');
    } // Add this line
    setState(() => isOn = !isOn);
    widget.onChanged(isOn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print('GestureDetector onTap triggered');
        }
        toggle();
      },
      onTapDown: (_) {
        if (kDebugMode) {
          print('onTapDown');
        }
      },
      onTapCancel: () {
        if (kDebugMode) {
          print('onTapCancel');
        }
      },
      child: SizedBox(
        width: 56.w,
        height: 36.h,
        child: Stack(
          children: [
            /// 🔹 Invisible tap area
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),

            /// 🔹 Background Switch
            Align(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 48.w,
                height: 24.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: isOn
                      ? AppColors.primaryColor
                      : Colors.grey.withOpacity(0.4),
                ),
              ),
            ),

            /// 🔹 Knob (الدائرة)
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: isOn
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    print('Knob tapped!');
                  }
                  toggle();
                },
                behavior: HitTestBehavior.translucent, // ← مهم جداً

                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 6.w),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5B8ED1),
                        Color(0xFF65DFE6),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isOn ? Icons.check : Icons.close_rounded,
                      size: 20.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
