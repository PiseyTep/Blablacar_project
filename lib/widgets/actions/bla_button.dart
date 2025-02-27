import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isPrimary;
  final bool loading;
  final VoidCallback? onPressed;

  const BlaButton({
    Key? key,
    required this.label,
    this.icon,
    this.isPrimary = true,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = isPrimary ? BlaColors.primary : BlaColors.white;

    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(
            vertical: BlaSpacings.l, horizontal: BlaSpacings.xxl),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius)),
      ),
      child: loading
          ? CircularProgressIndicator(color: BlaColors.white)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, size: 20, color: BlaColors.white),
                SizedBox(width: icon != null ? BlaSpacings.s : 0),
                Text(label,
                    style:
                        BlaTextStyles.button.copyWith(color: BlaColors.white)),
              ],
            ),
    );
  }
}
