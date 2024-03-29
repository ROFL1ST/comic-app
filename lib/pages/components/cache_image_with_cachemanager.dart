import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_app/helpers/cache_manager.dart';
import 'package:flutter/material.dart';


class NetworkImageWithCacheManager extends StatelessWidget {
  const NetworkImageWithCacheManager({Key? key, required this.imageUrl})
      : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      cacheManager: CustomCacheManager.instance,
      errorWidget: (context, _, widget) {
        return const Icon(Icons.error_sharp);
      },
      
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.screen,
    );
  }
}
