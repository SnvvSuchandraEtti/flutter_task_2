import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';



class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key}) : super(key: key);

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  bool _isInteracting = false;
  Timer? _interactionTimer;

  // Sample video data
  final List<ShortVideoModel> _videos = [
        ShortVideoModel(
      videoUrl: 'assets/keyrun_sir_periperi_0.50.mp4',
      username: '@keyrun',
      title: 'Peri Peri with me',
      likes: '1.4M',
      comments: '4,095',
      shares: '19K',
      musicTitle: 'Nature Sounds - Butterfly Wings',
      musicArtist: 'Tasty food',
      profileImageUrl: 'https://picsum.photos/seed/user1/200',
    ),
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      username: '@FlutterDev',
      title: 'Beautiful butterfly in slow motion 🦋',
      likes: '1.4M',
      comments: '4,095',
      shares: '19K',
      musicTitle: 'Nature Sounds - Butterfly Wings',
      musicArtist: 'EcoSounds',
      profileImageUrl: 'https://picsum.photos/seed/user1/200',
    ),
    ShortVideoModel(
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      username: '@NatureVideos',
      title: 'Busy bee collecting pollen 🐝',
      likes: '892K',
      comments: '2,157',
      shares: '12K',
      musicTitle: 'Buzzing Along - Summer Day',
      musicArtist: 'NatureTracks',
      profileImageUrl: 'https://picsum.photos/seed/user2/200',
    ),
    ShortVideoModel(
      videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
      username: '@TravelMoments',
      title: 'Spring flowers blooming in the garden 🌼',
      likes: '543K',
      comments: '1,849',
      shares: '8.2K',
      musicTitle: 'Spring Awakening',
      musicArtist: 'SeasonsMusic',
      profileImageUrl: 'https://picsum.photos/seed/user3/200',
    ),
    ShortVideoModel(
      videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-waves-in-the-water-1164-large.mp4',
      username: '@OceanViews',
      title: 'Relaxing ocean waves on a sunny day 🌊',
      likes: '2.1M',
      comments: '6,742',
      shares: '31K',
      musicTitle: 'Ocean Dreams',
      musicArtist: 'WaveSounds',
      profileImageUrl: 'https://picsum.photos/seed/user4/200',
    ),
    ShortVideoModel(
      videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
      username: '@ForestCalling',
      title: 'Peaceful stream in the forest 🌲',
      likes: '756K',
      comments: '3,210',
      shares: '14K',
      musicTitle: 'Forest Whispers',
      musicArtist: 'NatureSymphony',
      profileImageUrl: 'https://picsum.photos/seed/user5/200',
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _pageController.dispose();
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
      body: GestureDetector(
        onTap: _startInteractionTimer,
        child: Stack(
          children: [
            // Video PageView
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: _videos.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return ShortVideoPlayer(
                  video: _videos[index],
                  isCurrentlyPlaying: _currentPageIndex == index,
                  onDoubleTap: () {
                    // Double-tap to like functionality
                    // This would be implemented with animation in a complete app
                    print('Double tap liked video: ${_videos[index].title}');
                  },
                );
              },
            ),
            
            // App bar (visible on interaction)
            AnimatedOpacity(
              opacity: _isInteracting ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 16,
                  right: 16,
                ),
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shorts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom navigation (visible on interaction)
            AnimatedOpacity(
              opacity: _isInteracting ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  color: Colors.black.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomNavItem(icon: Icons.home, label: 'Home', onTap: () {}),
                      BottomNavItem(
                        icon: Icons.play_arrow_rounded,
                        label: 'Shorts',
                        isSelected: true,
                        onTap: () {},
                      ),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),
                      BottomNavItem(
                        icon: Icons.subscriptions_outlined,
                        label: 'Subscriptions',
                        onTap: () {},
                      ),
                      BottomNavItem(
                        icon: Icons.person_outline,
                        label: 'You',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Top category bar (visible on interaction)
            AnimatedOpacity(
              opacity: _isInteracting ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Positioned(
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  color: Colors.black.withOpacity(0.5),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      CategoryItem(icon: Icons.subscriptions_outlined, label: 'Subscriptions', onTap: () {}),
                      CategoryItem(icon: Icons.cast, label: 'Live', onTap: () {}),
                      CategoryItem(icon: Icons.local_fire_department_outlined, label: 'Trends', onTap: () {}),
                      CategoryItem(icon: Icons.shopping_bag_outlined, label: 'Shop', onTap: () {}),
                    ],
                  ),
                ),
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
        // Video player
        _isInitialized
            ? GestureDetector(
                onTap: _togglePlayPause,
                onDoubleTap: _handleDoubleTap,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
        
        // Buffering indicator
        if (_isBuffering && _isInitialized)
          const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        
        // Video information overlay
        Positioned(
          left: 16,
          right: 70, // Leave space for the action buttons
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.video.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.video.profileImageUrl),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.video.username,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
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
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.music_note, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${widget.video.musicTitle} · ${widget.video.musicArtist}',
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Action buttons
        Positioned(
          right: 16,
          bottom: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VideoActionButton(
                icon: Icons.thumb_up,
                label: widget.video.likes,
                onTap: () {},
              ),
              VideoActionButton(
                icon: Icons.thumb_down,
                label: 'Dislike',
                onTap: () {},
              ),
              VideoActionButton(
                icon: Icons.comment,
                label: widget.video.comments,
                onTap: () {},
              ),
              VideoActionButton(
                icon: Icons.share,
                label: widget.video.shares,
                onTap: () {},
              ),
              VideoActionButton(
                icon: Icons.replay,
                label: '',
                onTap: () {
                  _controller.seekTo(Duration.zero);
                  _playVideo();
                },
              ),
            ],
          ),
        ),
        
        // Progress indicator
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _isInitialized
              ? VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    // ignore: deprecated_member_use
                    backgroundColor: Colors.grey.withOpacity(0.5),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                )
              : const SizedBox(),
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
        if (!_isPlaying)
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

class VideoActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const VideoActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onTap,
          iconSize: 28,
        ),
        if (label.isNotEmpty)
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}
