// // // main.dart
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';



// class ShortsScreen extends StatefulWidget {
//   const ShortsScreen({super.key});

//   @override
//   State<ShortsScreen> createState() => _ShortsScreenState();
// }

// class _ShortsScreenState extends State<ShortsScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   // Mock video data
//   final List<String> videoUrls = [
//     'assets/keyrun_sir_periperi_0.50.mp4',
//     'assets/colours_event_2.40.mp4',
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset('assets/youtube_logo.png', height: 25),
//             const Icon(Icons.camera_alt_outlined),
//           ],
//         ),
//         backgroundColor: Colors.black.withOpacity(0.8),
//         elevation: 0,
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         scrollDirection: Axis.vertical,
//         itemCount: videoUrls.length,
//         onPageChanged: (int page) {
//           setState(() => _currentPage = page);
//         },
//         itemBuilder: (context, index) {
//           return VideoPlayerItem(
//             videoUrl: videoUrls[index],
//             isCurrent: index == _currentPage,
//           );
//         },
//       ),
//     );
//   }
// }

// class VideoPlayerItem extends StatefulWidget {
//   final String videoUrl;
//   final bool isCurrent;

//   const VideoPlayerItem({
//     super.key,
//     required this.videoUrl,
//     required this.isCurrent,
//   });

//   @override
//   State<VideoPlayerItem> createState() => _VideoPlayerItemState();
// }

// class _VideoPlayerItemState extends State<VideoPlayerItem> {
//   late VideoPlayerController _videoController;
//   ChewieController? _chewieController;
//   bool _showControls = true;
//   bool _isLiked = false;
//   int _likeCount = 1324;
//   bool _showHeart = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }

//   void _initializeVideo() async {
//     _videoController = VideoPlayerController.network(widget.videoUrl);
//     await _videoController.initialize();
    
//     _chewieController = ChewieController(
//       videoPlayerController: _videoController,
//       autoPlay: widget.isCurrent,
//       looping: true,
//       showControls: false,
//       autoInitialize: true,
//       errorBuilder: (context, errorMessage) {
//         return Center(child: Text('Error loading video: $errorMessage'));
//       },
//     );

//     if (mounted) setState(() {});
//   }

//   void _togglePlayPause() {
//     setState(() {
//       _chewieController!.isPlaying ? _chewieController?.pause() : _chewieController?.play();
//       _showControls = true;
//     });
//     _hideControlsAfterDelay();
//   }

//   void _hideControlsAfterDelay() {
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted && _chewieController?.isPlaying == true) {
//         setState(() => _showControls = false);
//       }
//     });
//   }

//   void _handleDoubleTap() {
//     setState(() {
//       _showHeart = true;
//       if (!_isLiked) {
//         _isLiked = true;
//         _likeCount += 1;
//       }
//     });
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (mounted) setState(() => _showHeart = false);
//     });
//   }

//   @override
//   void didUpdateWidget(covariant VideoPlayerItem oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.isCurrent) {
//       _chewieController?.play();
//     } else {
//       _chewieController?.pause();
//     }
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_chewieController == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return GestureDetector(
//       onTap: _togglePlayPause,
//       onDoubleTap: _handleDoubleTap,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Chewie(controller: _chewieController!),
//           if (_showControls)
//             AnimatedOpacity(
//               opacity: _showControls ? 1 : 0,
//               duration: const Duration(milliseconds: 300),
//               child: Icon(
//                 _chewieController!.isPlaying
//                     ? Icons.pause
//                     : Icons.play_arrow,
//                 size: 50,
//                 color: Colors.white,
//               ),
//             ),
//           _buildOverlayUI(),
//           if (_showHeart)
//             HeartAnimation(),
//         ],
//       ),
//     );
//   }

//   Widget _buildOverlayUI() {
//     return Stack(
//       children: [
//         Positioned(
//           bottom: 20,
//           left: 16,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 16,
//                     backgroundImage: NetworkImage('assets/youtube_logo.png'),
//                   ),
//                   SizedBox(width: 8),
//                   Text('@flutterdev', style: TextStyle(fontWeight: FontWeight.bold)),
//                   SizedBox(width: 8),
//                   Text('Follow', style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   )),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               const Text('Check out this amazing Flutter tutorial!'),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   const Icon(Icons.music_note, size: 16),
//                   const SizedBox(width: 4),
//                   const Text('Flutter Soundtrack - Official'),
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     margin: const EdgeInsets.only(left: 8),
//                     child: const Icon(Icons.graphic_eq, size: 16),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _buildProgressIndicator(),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           right: 16,
//           child: Column(
//             children: [
//               _buildActionButton(Icons.favorite, _likeCount.toString(), _isLiked),
//               _buildActionButton(Icons.comment, '324', false),
//               _buildActionButton(Icons.share, 'Share', false),
//               const Icon(Icons.more_vert, color: Colors.white),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProgressIndicator() {
//     return StreamBuilder<Duration>(
//       stream: _videoController.position.asStream().map((d) => d ?? Duration.zero),
//       builder: (context, snapshot) {
//         final position = snapshot.data ?? Duration.zero;
//         final duration = _videoController.value.duration;
//         if (duration == Duration.zero) return Container();
        
//         return SizedBox(
//           width: MediaQuery.of(context).size.width - 32,
//           child: LinearProgressIndicator(
//             value: position.inMilliseconds / duration.inMilliseconds,
//             backgroundColor: Colors.grey[800],
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildActionButton(IconData icon, String text, bool isActive) {
//     return Column(
//       children: [
//         Icon(icon, color: isActive ? Colors.red : Colors.white),
//         const SizedBox(height: 4),
//         Text(text, style: const TextStyle(fontSize: 12)),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// class HeartAnimation extends StatefulWidget {
//   const HeartAnimation({super.key});

//   @override
//   _HeartAnimationState createState() => _HeartAnimationState();
// }

// class _HeartAnimationState extends State<HeartAnimation> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     )..forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: CurvedAnimation(
//         parent: _controller,
//         curve: Curves.elasticOut,
//       ),
//       child: FadeTransition(
//         opacity: _controller,
//         child: const Icon(
//           Icons.favorite,
//           color: Colors.white,
//           size: 80,
//         ),
//       ),
//     );
//   }
// }