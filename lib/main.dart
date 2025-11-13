import 'package:flutter/material.dart';

void main() => runApp(const WallpaperCarouselApp());

class WallpaperCarouselApp extends StatelessWidget {
  const WallpaperCarouselApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Carousel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WallpaperCarousel(),
    );
  }
}

class WallpaperCarousel extends StatefulWidget {
  const WallpaperCarousel({super.key});

  @override
  State<WallpaperCarousel> createState() => _WallpaperCarouselState();
}

class _WallpaperCarouselState extends State<WallpaperCarousel> {
  // ✅ GitHub raw image URLs (make sure each URL opens in browser)
  final List<String> images = [
    'https://raw.githubusercontent.com/01-elite/Image-Switcher-App-Flutter/refs/heads/main/image1.jpeg',
    'https://raw.githubusercontent.com/01-elite/Image-Switcher-App-Flutter/refs/heads/main/image2.jpeg',
    'https://raw.githubusercontent.com/01-elite/Image-Switcher-App-Flutter/refs/heads/main/image3.jpeg',
    'https://raw.githubusercontent.com/01-elite/Image-Switcher-App-Flutter/refs/heads/main/image4.jpeg',
    'https://raw.githubusercontent.com/01-elite/Image-Switcher-App-Flutter/refs/heads/main/image5.jpeg',
  ];

  int currentIndex = 0;

  void nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
    });
  }

  void previousImage() {
    setState(() {
      currentIndex = (currentIndex - 1 + images.length) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ✅ Using network image with fade animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Image.network(
              images[currentIndex],
              key: ValueKey<String>(images[currentIndex]),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    'Failed to load image 😢',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
            ),
          ),

          // ⬅️ Previous Button
          Positioned(
            left: 20,
            child: IconButton(
              onPressed: previousImage,
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 40),
            ),
          ),

          // ➡️ Next Button
          Positioned(
            right: 20,
            child: IconButton(
              onPressed: nextImage,
              icon: const Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 40),
            ),
          ),

          // 🔘 Page indicator dots
          Positioned(
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 12 : 8,
                  height: currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? Colors.white
                        : Colors.white38,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
