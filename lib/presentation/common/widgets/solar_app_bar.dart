import 'package:flutter/material.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_theme.dart';
import 'package:solar_monitoring_app/presentation/common/extensions/context_extensions.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/text_label.dart';

class SolarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SolarAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        title: TextLabel(
          title,
          style: context.font.titleLarge?.semiBold.copyWith(
            color: context.color.onPrimary,
          ),
        ),
        backgroundColor: context.color.primary,
      );

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
