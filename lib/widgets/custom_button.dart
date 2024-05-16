import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButon extends StatelessWidget {
  const CustomButon({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: SizedBox(
          width: 190,
          height: 170 * 0.625,
          child: CustomPaint(
            // size: const Size(300, 200 * 0.625),
            painter: RPSCustomPainter(),
            child: Align(
                alignment: Alignment(-.08, .16),
                child: Text(title,
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromRGBO(255, 255, 255, 1)))),
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = Colors.blue
      ..shader = RadialGradient(colors: [
        Color.fromRGBO(27, 88, 231, 1),
        Color.fromRGBO(16, 71, 199, 1),
      ]).createShader(Rect.fromLTRB(0, 0, 300, 300))
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0000079, size.height * 0.8027649);
    path_0.lineTo(size.width * 0.1000002, size.height * 0.3038916);
    path_0.lineTo(size.width * 1.0000290, size.height * 0.2937218);
    path_0.lineTo(size.width * 0.9033685, size.height * 0.8027649);
    path_0.lineTo(size.width * -0.0000079, size.height * 0.8027649);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = Color.fromRGBO(27, 88, 231, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
