import 'package:flutter/material.dart';
import 'package:solar_monitoring_app/presentation/common/extensions/context_extensions.dart';

import '../design/app_size.dart';

class CenteredColumn extends StatelessWidget {
  final List<Widget> children;

  const CenteredColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: context.screenHeight - 250, // 250 for TabBar + NavBar height (est.) ,
        child: Padding(
          padding: AppSize.small.padding,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSize.expandedSpace,
                ...children,
                AppSize.expandedSpace,
              ],
            ),
          ),
        ),
      );
}
