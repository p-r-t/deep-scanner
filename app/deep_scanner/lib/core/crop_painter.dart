import 'package:deep_scanner/config.dart' as config;
import 'package:deep_scanner/core/crop_polygon.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class CropPainter extends CustomPainter {
  final CropPolygon cropPolygon;
  ui.Image image;

  CropPainter({@required this.cropPolygon, @required this.image});

  final _vertexPaint = Paint()
    ..color = config.primaryColor
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  final _edgePaint = Paint()
    ..color = config.primaryColor
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  final _fillPaint = Paint()
    ..color = config.primaryColor.withOpacity(0.25)
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) async {
//    canvas.drawImage(image, Offset.zero, Paint());
        canvas.drawImageRect(
        image,
        Rect.fromPoints(
            Offset.zero, Offset(image.width * 1.0, image.height * 1.0)),
        Rect.fromPoints(Offset(0, 200), Offset(size.width, size.height - 200)),
        Paint());

    canvas.drawPoints(ui.PointMode.polygon,
        [...cropPolygon.points, cropPolygon.points.first], _edgePaint);
    cropPolygon.points
        .forEach((offset) => canvas.drawCircle(offset, 8, _vertexPaint));

    final path = Path()..addPolygon(cropPolygon.points, true);
    canvas.drawPath(path, _fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
