import 'package:flutter/material.dart';

/// Image.asset with a grey fallback, so a missing/unsupported image
/// never crashes or breaks the layout on a real device.
Widget safeAsset(
  String path, {
  BoxFit fit = BoxFit.cover,
  double? width,
  double? height,
}) {
  return Image.asset(
    path,
    fit: fit,
    width: width,
    height: height,
    errorBuilder: (context, error, stackTrace) => Container(
      width: width,
      height: height,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    ),
  );
}

/// Round profile picture that always fills the circle (no stretching).
class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, required this.path, this.radius = 20});

  final String path;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: safeAsset(path, fit: BoxFit.cover),
      ),
    );
  }
}