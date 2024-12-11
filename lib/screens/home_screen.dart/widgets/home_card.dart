import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget homeCardWidget(
    {required IconData icon,
    required Color iconColor,
    required String text,
    VoidCallback? onTap,
    required String subTitle}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 4,
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 8,
          right: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 35,
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: textSize16(
                          text: text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child:
                  textSize14(text: subTitle, overFlow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    ),
  );
}
