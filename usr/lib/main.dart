import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SocialFeedScreen(),
    );
  }
}

class Post {
  final String username;
  final String userAvatarUrl;
  final String content;
  final String? imageUrl;
  int likes;
  int comments;
  int shares;
  bool isLiked;

  Post({
    required this.username,
    required this.userAvatarUrl,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
  });
}

class SocialFeedScreen extends StatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  final List<Post> posts = [
    Post(
      username: 'FlutterDev',
      userAvatarUrl: 'https://flutter.dev/images/flutter-logo-sharing.png',
      content: 'Just built this awesome social media feed with Flutter! The performance is amazing. #flutter #dart #mobiledev',
      imageUrl: 'https://images.unsplash.com/photo-1607799279861-4dd421887fb3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      likes: 1337,
      comments: 245,
      shares: 89,
    ),
    Post(
      username: 'CreativeCoder',
      userAvatarUrl: 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      content: 'Exploring the new Material 3 design guidelines. The dynamic colors are a game changer!',
      likes: 512,
      comments: 64,
      shares: 22,
    ),
    Post(
      username: 'NatureLover',
      userAvatarUrl: 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      content: 'Took a beautiful hike this morning. The views were breathtaking!',
      imageUrl: 'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      likes: 890,
      comments: 112,
      shares: 45,
    ),
     Post(
      username: 'FoodieExplorer',
      userAvatarUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      content: 'Trying out a new recipe tonight. This pasta is divine! 🍝',
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=1981&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      likes: 2300,
      comments: 450,
      shares: 150,
    ),
  ];

  void _handleLike(int index) {
    setState(() {
      if (posts[index].isLiked) {
        posts[index].likes--;
        posts[index].isLiked = false;
      } else {
        posts[index].likes++;
        posts[index].isLiked = true;
      }
    });
  }

  void _handleComment(int index) {
    setState(() {
      posts[index].comments++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Comments functionality would be implemented here."),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleShare(int index) {
    setState(() {
      posts[index].shares++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Share functionality would be implemented here."),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(
            post: post,
            onLike: () => _handleLike(index),
            onComment: () => _handleComment(index),
            onShare: () => _handleShare(index),
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.userAvatarUrl),
                ),
                const SizedBox(width: 10),
                Text(
                  post.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(post.content),
          ),
          if (post.imageUrl != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  post.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context: context,
                  icon: post.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                  label: '${post.likes} Likes',
                  onTap: onLike,
                  color: post.isLiked ? Theme.of(context).colorScheme.primary : Colors.grey[600],
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.comment_outlined,
                  label: '${post.comments} Comments',
                  onTap: onComment,
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.share_outlined,
                  label: '${post.shares} Shares',
                  onTap: onShare,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 20.0, color: color ?? Colors.grey[600]),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}
