import 'package:flutter/cupertino.dart';

extension WidgetExt on num {
  Widget get verticalSpace => SizedBox(
        height: toDouble(),
      );
  Widget get horizontalSpace => SizedBox(
        width: toDouble(),
      );
}
