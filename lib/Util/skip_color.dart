import 'package:flutter/material.dart';

import 'colors.dart';

class SkipBtn extends StatelessWidget {
  const SkipBtn({
    super.key,
    required this.size,
    required this.onTap,
  });

  final Size size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: size.width / 1.5,
      height: size.height / 13,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.btnBorderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        splashColor: MyColors.btnBorderColor,
        child: Center(
          child: Text(
            'Skip',
            style: TextStyle(
              fontSize: size.width / 22,
            ),
          ),
        ),
      ),
    );
  }
}
