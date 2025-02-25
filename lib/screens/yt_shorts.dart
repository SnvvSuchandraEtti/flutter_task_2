import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController pcontrol = PageController();
  int man = 0;
  bool _isInteracting = false;
  Timer? _interactionTimer;
  
  // Sample video data
  final List<ShortVideoModel> _videos = [
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      imageUrl: 'https://i.pinimg.com/736x/e4/03/74/e403746f8a1c72c7907d85f34b6a4103.jpg',
      username: '@FlutterDev',
      title: 'Beautiful butterfly in slow motion 🦋',
      likes: '1.4M',
      comments: '4,095',
      shares: '19K',
      musicTitle: 'Nature Sounds - Butterfly Wings',
      musicArtist: 'EcoSounds',
      profileImageUrl: 'https://i.pinimg.com/736x/cc/3c/91/cc3c918290fb841d8648f67bbe55583c.jpg',
    ),
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      imageUrl: 'https://i.pinimg.com/736x/7b/1b/a8/7b1ba89421f346de4c937d07166310f5.jpg',
      username: '@NatureVideos',
      title: 'Busy bee collecting pollen 🐝',
      likes: '892K',
      comments: '2,157',
      shares: '12K',
      musicTitle: 'Buzzing Along - Summer Day',
      musicArtist: 'NatureTracks',
      profileImageUrl: 'https://i.pinimg.com/736x/cc/3c/91/cc3c918290fb841d8648f67bbe55583c.jpg',
    ),
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      imageUrl: 'https://i.pinimg.com/736x/e4/03/74/e403746f8a1c72c7907d85f34b6a4103.jpg',
      username: '@FlutterDev',
      title: 'Beautiful butterfly in slow motion 🦋',
      likes: '1.4M',
      comments: '4,095',
      shares: '19K',
      musicTitle: 'Nature Sounds - Butterfly Wings',
      musicArtist: 'EcoSounds',
      profileImageUrl: 'https://i.pinimg.com/736x/cc/3c/91/cc3c918290fb841d8648f67bbe55583c.jpg',
    ),
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      imageUrl: 'https://i.pinimg.com/736x/7b/1b/a8/7b1ba89421f346de4c937d07166310f5.jpg',
      username: '@NatureVideos',
      title: 'Busy bee collecting pollen 🐝',
      likes: '892K',
      comments: '2,157',
      shares: '12K',
      musicTitle: 'Buzzing Along - Summer Day',
      musicArtist: 'NatureTracks',
      profileImageUrl: 'https://i.pinimg.com/736x/cc/3c/91/cc3c918290fb841d8648f67bbe55583c.jpg',
    ),
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      imageUrl: 'https://i.pinimg.com/736x/e4/03/74/e403746f8a1c72c7907d85f34b6a4103.jpg',
      username: '@FlutterDev',
      title: 'Beautiful butterfly in slow motion 🦋',
      likes: '1.4M',
      comments: '4,095',
      shares: '19K',
      musicTitle: 'Nature Sounds - Butterfly Wings',
      musicArtist: 'EcoSounds',
      profileImageUrl: 'https://i.pinimg.com/736x/cc/3c/91/cc3c918290fb841d8648f67bbe55583c.jpg',
    ),
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      imageUrl: 'https://i.pinimg.com/736x/7b/1b/a8/7b1ba89421f346de4c937d07166310f5.jpg',
      username: '@NatureVideos',
      title: 'Busy bee collecting pollen 🐝',
      likes: '892K',
      comments: '2,157',
      shares: '12K',
      musicTitle: 'Buzzing Along - Summer Day',
      musicArtist: 'NatureTracks',
      profileImageUrl: 'https://i.pinimg.com/736x/cc/3c/91/cc3c918290fb841d8648f67bbe55583c.jpg',
    ),
  ];


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    pcontrol.dispose();
    _interactionTimer?.cancel();
    super.dispose();
  }

  void _startInteractionTimer() {
    setState(() {
      _isInteracting = true;
    });
    
    _interactionTimer?.cancel();
    _interactionTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _isInteracting = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Shorts",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            const SizedBox(width: 240),
            const Icon(Icons.search, color: Colors.white, size: 30),
            const SizedBox(width: 20),
            const Icon(Icons.more_vert_outlined, color: Colors.white, size: 28),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: _startInteractionTimer,
        child: Stack(
          children: [
            // Video PageView
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: pcontrol,
              itemCount: _videos.length,
              onPageChanged: (index) {
                setState(() {
                  man = index;
                });
              },
              itemBuilder: (context, index) {
                return ShortVideoPlayer(
                  video: _videos[index],
                  isCurrentlyPlaying: man == index,
                  onDoubleTap: () {
                    // Double-tap to like functionality
                    print('Double tap liked video: ${_videos[index].title}');
                  },
                );
              },
            ),
            
            // Right side action buttons
            Positioned(
              top: 320,
              right: 10,
              child: Column(
                children: [
                  Column(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined, color: Colors.white, size: 25),
                      Text(_videos[man].likes, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Column(
                    children: [
                      Icon(Icons.thumb_down_off_alt_outlined, color: Colors.white, size: 25),
                      Text("Dislike", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      const Icon(Icons.message_outlined, color: Colors.white, size: 25),
                      Text(_videos[man].comments, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Column(
                    children: [
                      Icon(Icons.reply, color: Colors.white, size: 25),
                      Text("Share", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      const Icon(Icons.share_location_rounded, color: Colors.white, size: 25),
                      Text(_videos[man].shares, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Image.network("https://i.pinimg.com/736x/47/6e/c5/476ec57d69fc0a5424d74a72a8257c73.jpg", fit: BoxFit.fill),
                  )
                ],
              )
            ),
            
            // User profile at bottom
            Positioned(
              bottom: 80,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(_videos[man].profileImageUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _videos[man].username,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(80, 30),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text('Subscribe'),
                    ),
                  ],
                ),
              )
            ),
            
            // Category tabs at top
            AnimatedOpacity(
              opacity: _isInteracting ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Positioned(
                left: 10,
                top: 10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white24,
                        ),
                        child: const Center(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.video_settings, color: Colors.white),
                              Text("  Subscription", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 90,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white24,
                        ),
                        child: const Center(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.share_location_rounded, color: Colors.white),
                              Text(" Live", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white24,
                        ),
                        child: const Center(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.local_fire_department, color: Colors.white),
                              Text("  Trends", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Music info
            Positioned(
              bottom: 40,
              left: 20,
              child: Row(
                children: [
                  const Icon(Icons.music_note, size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '${_videos[man].musicTitle} · ${_videos[man].musicArtist}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Progress indicator
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: LinearProgressIndicator(
                value: 0.3, // This would be connected to actual video progress
                backgroundColor: Colors.grey.withOpacity(0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                minHeight: 3,
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class ShortVideoModel {
  final String videoUrl;
  final String imageUrl;
  final String username;
  final String title;
  final String likes;
  final String comments;
  final String shares;
  final String musicTitle;
  final String musicArtist;
  final String profileImageUrl;

  ShortVideoModel({
    required this.videoUrl,
    required this.imageUrl,
    required this.username,
    required this.title,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.musicTitle,
    required this.musicArtist,
    required this.profileImageUrl,
  });
}

class ShortVideoPlayer extends StatefulWidget {
  final ShortVideoModel video;
  final bool isCurrentlyPlaying;
  final VoidCallback onDoubleTap;

  const ShortVideoPlayer({
    Key? key,
    required this.video,
    required this.isCurrentlyPlaying,
    required this.onDoubleTap,
  }) : super(key: key);

  @override
  State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isBuffering = false;
  bool _showLikeAnimation = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(ShortVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle auto-play and pause based on visibility
    if (widget.isCurrentlyPlaying && !oldWidget.isCurrentlyPlaying) {
      _playVideo();
    } else if (!widget.isCurrentlyPlaying && oldWidget.isCurrentlyPlaying) {
      _pauseVideo();
    }
    
    // Handle video URL changes
    if (widget.video.videoUrl != oldWidget.video.videoUrl) {
      _disposeVideo();
      _initializeVideo();
    }
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.network(widget.video.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          if (widget.isCurrentlyPlaying) {
            _playVideo();
          }
        });
        
        // Set up listener for buffering state
        _controller.addListener(() {
          final newBuffering = _controller.value.isBuffering;
          if (newBuffering != _isBuffering) {
            setState(() {
              _isBuffering = newBuffering;
            });
          }
        });
        
        // Set video to loop
        _controller.setLooping(true);
      }).catchError((error) {
        print('Error initializing video: $error');
        setState(() {
          _isError = true;
        });
      });
  }

  void _playVideo() {
    if (_isInitialized && !_isPlaying) {
      _controller.play();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _pauseVideo() {
    if (_isInitialized && _isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _pauseVideo();
    } else {
      _playVideo();
    }
  }

  void _handleDoubleTap() {
    widget.onDoubleTap();
    setState(() {
      _showLikeAnimation = true;
    });
    
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showLikeAnimation = false;
        });
      }
    });
  }

  void _disposeVideo() {
    _controller.dispose();
    _isInitialized = false;
    _isPlaying = false;
  }

  @override
  void dispose() {
    _disposeVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Fallback image or video player
        if (_isError || !_isInitialized)
          Image.network(
            widget.video.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        else
          GestureDetector(
            onTap: _togglePlayPause,
            onDoubleTap: _handleDoubleTap,
            child: VideoPlayer(_controller),
          ),
        
        // Loading indicator
        if (_isBuffering && _isInitialized)
          const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
          
        // Video title overlay
        Positioned(
          top: 8,
          left: 5,
          right: 50,
          child: Text(
            widget.video.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(212, 255, 255, 255),
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        
        // Double-tap like animation
        if (_showLikeAnimation)
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 400),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value > 0.8 ? 2 - value * 2 : value,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 120,
                    ),
                  ),
                );
              },
            ),
          ),
        
        // Play/pause icon overlay (shows briefly when toggled)
        if (!_isPlaying && _isInitialized)
          const Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 80,
            ),
          ),
      ],
    );
  }
}

