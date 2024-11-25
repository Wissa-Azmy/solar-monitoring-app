import 'package:flutter/material.dart';

import '../centered_column.dart';
import '../text_label.dart';

class ErrorView extends StatelessWidget {
  final String error;

  const ErrorView({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) => CenteredColumn(
        children: [
          const TextLabel('Something wrong happened!'),
          TextLabel(error),
        ],
      );
}
