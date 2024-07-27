import 'package:flutter/material.dart';

class ResponsiveButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;

  const ResponsiveButton({
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  _ResponsiveButtonState createState() => _ResponsiveButtonState();
}

class _ResponsiveButtonState extends State<ResponsiveButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.red.withOpacity(0.8) : widget.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: 15.0,
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
