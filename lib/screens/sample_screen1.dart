// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';


// class ShortsScreen extends StatefulWidget {
//   const ShortsScreen({Key? key}) : super(key: key);

//   @override
//   State<ShortsScreen> createState() => _ShortsScreenState();
// }

// class _ShortsScreenState extends State<ShortsScreen> {
//   final PageController _pageController = PageController();
  
//   // Mock data for shorts

// final List<Map<String, dynamic>> _shorts = [
//     {
//       'username': '@divacar',
//       'description': 'Attempting the bottle flip challenge! 🔄 #challenge #viral',
//       'likes': '892K',
//       'comments': '5.6K',
//       'shares': '78K',
//       'userImage': 'https://randomuser.me/api/portraits/men/32.jpg',
//       'isMusicPlaying': true,
//       'musicName': 'Viral Beats - Challenge Mix',
//     },
//     {
//       'username': 'manohar',
//       'description': 'iPhone 15 Pro Max vs Android - Camera Test 📱 #tech #comparison',
//       'likes': '445K',
//       'comments': '12.3K',
//       'shares': '34K',
//       'userImage': 'https://randomuser.me/api/portraits/women/44.jpg',
//       'isMusicPlaying': true,
//       'musicName': 'Tech Review Background',
//     },
//     {
//       'username': '@saiteja',
//       'description': 'Magic card tricks that will blow your mind! 🎭 #magic #illusion',
//       'likes': '1.2M',
//       'comments': '15.7K',
//       'shares': '203K',
//       'userImage': 'https://randomuser.me/api/portraits/women/68.jpg',
//       'isMusicPlaying': true,
//       'musicName': 'Mystical Tunes - Magic Edition',
//     },
//     {
//       'username': '@shivareddy',
//       'description': 'Extreme parkour in New York City! 🏃‍♂️ #parkour #urban',
//       'likes': '678K',
//       'comments': '4.5K',
//       'shares': '89K',
//       'userImage': 'https://randomuser.me/api/portraits/women/68.jpg',
//       'isMusicPlaying': true,
//       'musicName': 'Action Beats - Adrenaline Mix',
//     },
//     {
//       'username': '@sameer',
//       'description': 'DIY room transformation in 24 hours! 🎨 #diy #roomdecor',
//       'likes': '334K',
//       'comments': '7.8K',
//       'shares': '45K',
//       'userImage': 'https://randomuser.me/api/portraits/women/68.jpg',
//       'isMusicPlaying': true,
//       'musicName': 'Creative Vibes - DIY Music',
//     },
//     {
//       'username': '@keyrun',
//       'description': 'Street food tour in Tokyo! 🍜 #japan #foodie',
//       'likes': '567K',
//       'comments': '9.1K',
//       'shares': '67K',
//       'userImage': 'https://randomuser.me/api/portraits/women/99.jpg',
//       'isMusicPlaying': true,
//       'musicName': 'Tokyo Streets - Food Adventures',
//     },
// ];
  

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         controller: _pageController,
//         scrollDirection: Axis.vertical,
//         itemCount: _shorts.length,
//         itemBuilder: (context, index) {
//           return ShortVideoItem(shortData: _shorts[index]);
//         },
//       ),
//     );
//   }
// }

// class ShortVideoItem extends StatefulWidget {
//   final Map<String, dynamic> shortData;

//   const ShortVideoItem({Key? key, required this.shortData}) : super(key: key);

//   @override
//   State<ShortVideoItem> createState() => _ShortVideoItemState();
// }

// class _ShortVideoItemState extends State<ShortVideoItem> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = true;

//   @override
//   void initState() {
//     super.initState();
//     
//     _controller = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
//       ..initialize().then((_) {
//         _controller.play();
//         _controller.setLooping(true);
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//       _isPlaying = !_isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         
//         GestureDetector(
//           onTap: _togglePlayPause,
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                   ),
//                 ),
//         ),

//         
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         
//                         Text(
//                           widget.shortData['username'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         
//                         Text(
//                           widget.shortData['description'],
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 8),
//                         
//                         Row(
//                           children: [
//                             const Icon(Icons.music_note, size: 15),
//                             const SizedBox(width: 4),
//                             Expanded(
//                               child: Text(
//                                 widget.shortData['musicName'],
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       
//                       CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colors.grey,
//                         child: const Icon(Icons.person, color: Colors.white),
//                       ),
//                       const SizedBox(height: 4),
//                       const Icon(
//                         Icons.add,
//                         size: 15,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(height: 20),
                      
//                       
//                       Column(
//                         children: [
//                           const Icon(Icons.favorite_border, size: 30),
//                           const SizedBox(height: 4),
//                           Text(widget.shortData['likes']),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
                      
//                       
//                       Column(
//                         children: [
//                           const Icon(Icons.comment_outlined, size: 30),
//                           const SizedBox(height: 4),
//                           Text(widget.shortData['comments']),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
                      
//                      
//                       Column(
//                         children: [
//                           const Icon(Icons.reply, size: 30),
//                           const SizedBox(height: 4),
//                           Text(widget.shortData['shares']),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
                      
//                       
//                       const Icon(Icons.more_horiz, size: 30),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
            
//             
//             Container(
//               height: 50,
//               color: Colors.black,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.home, color: Colors.white),
//                       const Text('Home', style: TextStyle(fontSize: 10)),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.explore_outlined),
//                       const Text('Discover', style: TextStyle(fontSize: 10)),
//                     ],
//                   ),
//                   const CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Colors.red,
//                     child: Icon(Icons.add, color: Colors.white),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.subscriptions_outlined),
//                       const Text('Subscriptions', style: TextStyle(fontSize: 10)),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.video_library_outlined),
//                       const Text('Library', style: TextStyle(fontSize: 10)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
        
//         
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Shorts',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Icon(Icons.search, size: 24),
//                 const Icon(Icons.camera_alt_outlined, size: 24),
//                 const Icon(Icons.more_vert, size: 24),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
