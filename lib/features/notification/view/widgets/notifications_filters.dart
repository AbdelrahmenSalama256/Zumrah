import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/locale/app_loacl.dart';

import '../notifications_screen.dart';

class NotificationFilters extends StatelessWidget {
  final NotifFilter selected;
  final ValueChanged<NotifFilter> onChanged;
  final Map<NotifFilter, int> counts;

  const NotificationFilters({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.counts,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChipItem(
            label: "all".tr(context),
            isSelected: selected == NotifFilter.all,
            onTap: () => onChanged(NotifFilter.all),
            lenght: (counts[NotifFilter.all] ?? 0).toString(),
          ),
          SizedBox(width: 8.w),
          _FilterChipItem(
            label: "unread".tr(context),
            isSelected: selected == NotifFilter.unread,
            onTap: () => onChanged(NotifFilter.unread),
            lenght: (counts[NotifFilter.unread] ?? 0).toString(),
          ),
          SizedBox(width: 8.w),
          _FilterChipItem(
            label: "important".tr(context),
            isSelected: selected == NotifFilter.important,
            onTap: () => onChanged(NotifFilter.important),
            lenght: (counts[NotifFilter.important] ?? 0).toString(),
          ),
          SizedBox(width: 8.w),
          _FilterChipItem(
            label: "system".tr(context),
            isSelected: selected == NotifFilter.system,
            onTap: () => onChanged(NotifFilter.system),
            lenght: (counts[NotifFilter.system] ?? 0).toString(),
          ),
        ],
      ),
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final String? lenght;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChipItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.lenght,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          gradient: isSelected
              ? LinearGradient(
                  begin: AlignmentDirectional.centerEnd,
                  end: AlignmentDirectional.centerStart,
                  colors: [
                    AppColors.g1,
                    AppColors.g2,
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.5),
                  ],
                ),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.primaryColor,
              ),
            ),
            if (lenght != null)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 20.w,
                height: 20.w,
                margin: EdgeInsetsDirectional.only(start: 10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff0e4f93).withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    lenght ?? "0",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color:
                          isSelected ? AppColors.white : AppColors.primaryColor,
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
