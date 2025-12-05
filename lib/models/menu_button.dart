import 'package:flutter/material.dart';

class CustomMenuButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool isSelected;

  const CustomMenuButton({
    super.key,
    required this.label,
    this.onTap,
    this.width = 110,
    this.height = 30,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderRadius = 20,
    this.textStyle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isSelected
        ? Theme.of(context).colorScheme.primary
        : backgroundColor;
    final txtColor = isSelected ? Colors.white : textColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            label,
            style: textStyle ?? TextStyle(color: txtColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
