
import 'dart:math';

import 'package:flutter/material.dart';

class LiquidPainter extends CustomPainter {
  final double value;
  final double maxValue;

  /// Creates a [LiquidPainter] with the given [value] and [maxValue].
  LiquidPainter(this.value, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    double diameter = min(size.height, size.width);
    print(diameter);
    double radius = diameter / 2;

    // Defining coordinate points. The wave starts from the bottom and ends at the top as the value changes.
    double pointX = 0;
    double pointY = diameter -
        ((diameter + 10) *
            (value /
                maxValue)); // 10 is an extra offset added to fill the circle completely

    Path path = Path();
    path.moveTo(pointX, pointY);

    // Amplitude: the height of the sine wave
    double amplitude = 10;

    // Period: the time taken to complete one full cycle of the sine wave.
    // f = 1/p, the more the value of the period, the higher the frequency.
    double period = value / maxValue;

    // Phase Shift: the horizontal shift of the sine wave along the x-axis.
    double phaseShift = value * pi;

    // Plotting the sine wave by connecting various paths till it reaches the diameter.
    // Using this formula: y = A * sin(ωt + φ) + C
    for (double i = 0; i <= diameter; i++) {
      path.lineTo(
        i + pointX,
        pointY + amplitude * sin((i * 2 * period * pi / diameter) + phaseShift),
      );
    }

    // Plotting a vertical line which connects the right end of the sine wave.
    path.lineTo(pointX + diameter, diameter);
    // Plotting a vertical line which connects the left end of the sine wave.
    path.lineTo(pointX, diameter);
    // Closing the path.
    path.close();

    Paint paint = Paint()
      ..shader = const SweepGradient(
              colors: [
                Color(0xffFF7A01),
                Color(0xffFF0069),
                Color(0xff7639FB),
              ],
              startAngle: pi / 2,
              endAngle: 5 * pi / 2,
              tileMode: TileMode.clamp,
              stops: [
                0.25,
                0.35,
                0.5,
              ])
          .createShader(Rect.fromCircle(
              center: Offset(diameter, diameter), radius: radius))
      ..style = PaintingStyle.fill;

    // Clipping rectangular-shaped path to Oval.
    Path circleClip = Path()
      ..addOval(Rect.fromCenter(
          center: Offset(radius, radius), width: diameter, height: diameter));
    canvas.clipPath(circleClip, doAntiAlias: true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RadialProgressPainter extends CustomPainter {
  final double value;
  final List<Color> backgroundGradientColors;
  final double minValue;
  final double maxValue;

  // Constructor to initialize the RadialProgressPainter with required parameters.
  RadialProgressPainter({
    required this.value,
    required this.backgroundGradientColors,
    required this.minValue,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // circle's diameter // taking min side as diameter
    final double diameter = min(size.height, size.width);
    // Radius
    final double radius = diameter / 2;
    // Center cordinate
    final double centerX = radius;
    final double centerY = radius;

    const double strokeWidth = 6;

    // Paint for the progress with gradient colors.
    final Paint progressPaint = Paint()
      ..shader = SweepGradient(
        colors: backgroundGradientColors,
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        tileMode: TileMode.repeated,
      ).createShader(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Paint for the progress track.
    final Paint progressTrackPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Calculate the start and sweep angles to draw the progress arc.
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * value / maxValue;

    // Drawing track.
    canvas.drawCircle(Offset(centerX, centerY), radius, progressTrackPaint);
    // Drawing progress.
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
