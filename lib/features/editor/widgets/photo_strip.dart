/// Düzenleme ekranının altındaki küçük resim şeridi.
/// Birden fazla fotoğraf varken seçimi ve her fotoğrafın işlenme durumunu gösterir.
library;

import 'dart:io';

import 'package:flutter/material.dart';

import '../editor_controller.dart';

/// Birden fazla fotoğraf varken altta görünen küçük resim şeridi.
class PhotoStrip extends StatelessWidget {
  const PhotoStrip({
    super.key,
    required this.photos,
    required this.selectedIndex,
    required this.onSelect,
  });

  static const _size = 64.0;

  final List<EditorPhoto> photos;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) => _Thumbnail(
          photo: photos[index],
          selected: index == selectedIndex,
          onTap: () => onSelect(index),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.photo,
    required this.selected,
    required this.onTap,
  });

  final EditorPhoto photo;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final imagePath = photo.cutout?.path ?? photo.sourcePath;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: PhotoStrip._size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outlineVariant,
            width: selected ? 2.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(File(imagePath), fit: BoxFit.contain, cacheWidth: 160),
            if (photo.status == PhotoStatus.processing)
              const ColoredBox(
                color: Colors.white70,
                child: Center(
                  child: SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            if (photo.status == PhotoStatus.failed)
              ColoredBox(
                color: Colors.white70,
                child: Icon(Icons.error_outline_rounded, color: scheme.error),
              ),
          ],
        ),
      ),
    );
  }
}
