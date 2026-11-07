import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({super.key, this.url, this.fit = BoxFit.cover});

  final String? url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final imageUrl = url;
    if (imageUrl == null || imageUrl.isEmpty) {
      return const ImagePlaceholder();
    }

    return ColoredBox(
      color: Colors.grey.shade200,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: (_, _) => const ImagePlaceholder(loading: true),
        errorWidget: (_, _, _) => const ImagePlaceholder(),
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key, this.loading = false});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: Center(
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.image_outlined, color: Colors.grey),
      ),
    );
  }
}
