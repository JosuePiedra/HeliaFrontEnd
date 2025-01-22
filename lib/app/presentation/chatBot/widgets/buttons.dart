import 'package:flutter/material.dart';
import 'package:helia_frontend/app/themes/custom_margin.dart';
import 'package:helia_frontend/app/themes/font_size.dart';
import 'package:helia_frontend/app/themes/responsive.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final Responsive responsive = Responsive();

  ActionButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(responsive.ip(1)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: responsive.wp(70),
        height: responsive.hp(5.5),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsive.ip(1)),
                    bottomLeft: Radius.circular(responsive.ip(1))),
              ),
              alignment: Alignment.center,
              height: responsive.hp(5.5),
              width: responsive.wp(15),
              child: Icon(icon, color: color, size: responsive.ip(2.5)),
            ),
            ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  color: Colors.white,
                  height: responsive.hp(3),
                  width: responsive.wp(3),
                )),
            customXMargin(responsive.wp(3)),
            Text(
              text,
              style: TextStyle(
                  fontSize: FontSize.body.medium,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width - 20, 0); // Increased from 20 to 40
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height); // Increased from 20 to 40
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
