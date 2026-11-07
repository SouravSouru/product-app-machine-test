import 'package:flutter/material.dart';
import 'package:product_app/core/widgets/app_Network_image.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({
    super.key,
    required this.imageUrls,
    this.heroTag,
    this.height = 280,
  });

  final List<String> imageUrls;
  final String? heroTag;
  final double height;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final _controller = PageController();
  var _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.imageUrls;

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: urls.isEmpty
          ? framed(const AppNetworkImage(), 0)
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: urls.length,
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    return framed(
                      AppNetworkImage(url: urls[index], fit: BoxFit.contain),
                      index,
                    );
                  },
                ),
                if (urls.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(999),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var i = 0; i < urls.length; i++)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: i == _index ? 16 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: i == _index
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.55),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  Widget framed(Widget image, int index) {
    final heroTag = widget.heroTag;
    if (heroTag == null || index != 0) return image;
    return Hero(tag: heroTag, child: image);
  }
}
