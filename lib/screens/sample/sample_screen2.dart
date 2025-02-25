import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';


// class ShortVideo {
//   final String url;
//   final String title;
//   final String username;
//   final String musicTrack;
//   final int likes;
//   final int comments;
//   final int shares;

//   ShortVideo({
//     required this.url,
//     required this.title,
//     required this.username,
//     required this.musicTrack,
//     required this.likes,
//     required this.comments,
//     required this.shares,
//   });
// }

// class Yt_ShortsScreen extends StatefulWidget {
//   const Yt_ShortsScreen({Key? key}) : super(key: key);

//   @override
//   State<Yt_ShortsScreen> createState() => _Yt_ShortsScreenState();
// }

// class _Yt_ShortsScreenState extends State<Yt_ShortsScreen> {
//   final PageController _pageController = PageController();
//   final List<ShortVideo> _videos = [
//     ShortVideo(
//       url: 'assets/colours_event_2.40.mp4',
//       title: 'A relaxing video of a butterfly',
//       username: 'NatureChannel',
//       musicTrack: 'Nature BGM',
//       likes: 1200,
//       comments: 300,
//       shares: 50,
//     ),
//     ShortVideo(
//       url: 'assets/keyrun_sir_periperi_0.50.mp4',
//       title: 'Sample short clip #1',
//       username: 'SampleUser1',
//       musicTrack: 'Trending Music',
//       likes: 580,
//       comments: 45,
//       shares: 10,
//     ),
//     ShortVideo(
//       url: 'assets/colours_event_2.40.mp4',
//       title: 'Sample short clip #2',
//       username: 'SampleUser2',
//       musicTrack: 'Cool Beat',
//       likes: 1050,
//       comments: 210,
//       shares: 75,
//     ),
//   ];

//   final List<VideoPlayerController> _controllers = [];

//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//     _pageController.addListener(_pageScrollListener);
//   }

//   void _initializeControllers() {
//     for (var video in _videos) {
//       final controller = VideoPlayerController.network(video.url)
//         ..initialize().then((_) {
//           setState(() {}); 
//         });
//       _controllers.add(controller);
//     }
//     if (_controllers.isNotEmpty) {
//       _controllers.first.play();
//     }
//   }

//   void _pageScrollListener() {
//     final newIndex = _pageController.page?.round();
//     if (newIndex != null && newIndex != _currentIndex) {
//       _pauseAllExcept(newIndex);
//       _currentIndex = newIndex;
//     }
//   }

//   void _pauseAllExcept(int index) {
//     for (int i = 0; i < _controllers.length; i++) {
//       if (i == index) {
//         _controllers[i].play();
//       } else {
//         _controllers[i].pause();
//       }
//     }
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _pageController.removeListener(_pageScrollListener);
//     _pageController.dispose();
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   Widget _buildVideoPage(int index) {
//     final video = _videos[index];
//     final controller = _controllers[index];

//     return ShortVideoPlayer(
//       controller: controller,
//       videoData: video,
//       onLikePressed: () {
//         setState(() {
//           _videos[index] = ShortVideo(
//             url: video.url,
//             title: video.title,
//             username: video.username,
//             musicTrack: video.musicTrack,
//             likes: video.likes + 1,
//             comments: video.comments,
//             shares: video.shares,
//           );
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Image.asset(
//           'assets/youtube_logo.png',
//           height: 200,
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.camera_alt_outlined),
//             onPressed: () {
//               debugPrint('Camera icon tapped');
//             },
//           ),
//         ],
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: PageView.builder(
//         scrollDirection: Axis.vertical,
//         controller: _pageController,
//         itemCount: _videos.length,
//         itemBuilder: (context, index) {
//           return _buildVideoPage(index);
//         },
//       ),
//     );
//   }
// }

// class ShortVideoPlayer extends StatefulWidget {
//   final VideoPlayerController controller;
//   final ShortVideo videoData;
//   final VoidCallback onLikePressed;

//   const ShortVideoPlayer({
//     Key? key,
//     required this.controller,
//     required this.videoData,
//     required this.onLikePressed,
//   }) : super(key: key);

//   @override
//   State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
// }

// class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
//   bool _isPlaying = true;
//   bool _showControls = true;
//   bool _isLiked = false;

//   Timer? _hideControlsTimer;

//   @override
//   void initState() {
//     super.initState();
//     _startHideControlsTimer();
//   }

//   @override
//   void dispose() {
//     _hideControlsTimer?.cancel();
//     super.dispose();
//   }

//   void _startHideControlsTimer() {
//     _hideControlsTimer?.cancel();
//     _hideControlsTimer = Timer(const Duration(seconds: 2), () {
//       setState(() {
//         _showControls = false;
//       });
//     });
//   }

//   void _togglePlayPause() {
//     if (widget.controller.value.isPlaying) {
//       widget.controller.pause();
//       _isPlaying = false;
//     } else {
//       widget.controller.play();
//       _isPlaying = true;
//     }
//     setState(() {});
//   }

//   void _onTap() {
//     setState(() {
//       _showControls = true;
//     });
//     _startHideControlsTimer();
//     _togglePlayPause();
//   }

//   void _onDoubleTap() {
//     setState(() {
//       _isLiked = true;
//       widget.onLikePressed(); 
//     });
//     _startHideControlsTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = widget.controller;
//     final videoData = widget.videoData;

//     return GestureDetector(
//       onTap: _onTap,
//       onDoubleTap: _onDoubleTap,
//       child: Stack(
//         children: [
//           /// The Video Player
//           SizedBox.expand(
//             child: controller.value.isInitialized
//                 ? VideoPlayer(controller)
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//           ),

//           /// Fade or show an overlay for buffering
//           if (controller.value.isBuffering)
//             const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//               ),
//             ),

//           /// Video overlay (controls, info, etc.)
//           if (_showControls) ...[
//             // Dark gradient at bottom for text readability
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 300,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.transparent, Colors.black54],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//             ),

//             /// Bottom-left info: Title, username, music track, subscribe
//             Positioned(
//               bottom: 60,
//               left: 16,
//               right: 100, // leave space for the right icons
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '@${videoData.username}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     videoData.title,
//                     style: const TextStyle(fontSize: 14),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       // Music equalizer icon (placeholder)
//                       const Icon(Icons.graphic_eq, size: 16, color: Colors.white),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           videoData.musicTrack,
//                           style: const TextStyle(fontSize: 12),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: () {
//                       debugPrint('Subscribe button pressed');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                     ),
//                     child: const Text('SUBSCRIBE'),
//                   ),
//                 ],
//               ),
//             ),

//             /// Right-side action buttons: Like, comment, share, etc.
//             Positioned(
//               bottom: 60,
//               right: 16,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _ActionButton(
//                     icon: Icons.favorite,
//                     label: '${videoData.likes}',
//                     color: _isLiked ? Colors.red : Colors.white,
//                     onTap: () {
//                       setState(() {
//                         _isLiked = !_isLiked;
//                         if (_isLiked) {
//                           widget.onLikePressed();
//                         }
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   _ActionButton(
//                     icon: Icons.chat_bubble_outline,
//                     label: '${videoData.comments}',
//                     onTap: () => debugPrint('Comment tapped'),
//                   ),
//                   const SizedBox(height: 16),
//                   _ActionButton(
//                     icon: Icons.share,
//                     label: '${videoData.shares}',
//                     onTap: () => debugPrint('Share tapped'),
//                   ),
//                   const SizedBox(height: 16),
//                   _ActionButton(
//                     icon: Icons.more_vert,
//                     label: '',
//                     onTap: () => debugPrint('More options tapped'),
//                   ),
//                 ],
//               ),
//             ),

//             /// A simple play/pause icon in the center
//             Center(
//               child: Icon(
//                 _isPlaying ? Icons.play_arrow : Icons.pause,
//                 color: Colors.white54,
//                 size: 48,
//               ),
//             ),
//           ],

//           /// Progress bar or timeline
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: VideoProgressIndicator(
//               controller,
//               allowScrubbing: false,
//               colors: const VideoProgressColors(
//                 playedColor: Colors.red,
//                 bufferedColor: Colors.white54,
//                 backgroundColor: Colors.white24,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// A helper widget for the right-side action buttons
// class _ActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final Color color;

//   const _ActionButton({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.color = Colors.white,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 32),
//           if (label.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text(
//                 label,
//                 style: const TextStyle(fontSize: 12),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }





