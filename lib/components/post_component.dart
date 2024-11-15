import 'dart:ui';

import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final Function(String) onLike;
  final Function(String) onComment;

  const PostWidget({
    required this.post,
    required this.onLike,
    required this.onComment,
    super.key,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.userThumbnailUrl),
                ),
                const SizedBox(width: 8),
                Text(widget.post.username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(
                  _formatTimestamp(widget.post.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Post Text
            Text(widget.post.text),
            // Post Image (if available)
            if (widget.post.imageUrl != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.network(widget.post.imageUrl!),
              ),
            // Likes and Comments
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.red[600],
                    size: 14,
                  ),
                  onPressed: () {
                    widget.onLike(widget.post.id);
                  },
                ),
                Text(widget.post.likes.toString()),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.comment,
                    color: Colors.amber[700],
                    size: 14,
                  ),
                  onPressed: () {
                    _showCommentDialog(context);
                  },
                ),
                Text(widget.post.comments.length.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  void _showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing when tapping outside
      builder: (context) {
        return AlertDialog(
          //insetPadding: const EdgeInsets.all(10),
          title: const Text(
            'Add a comment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 150, // Limiting the height of the TextField
              ),
              child: TextField(
                style: const TextStyle(fontSize: 14),
                controller: _commentController,
                maxLines: 5, // Limit the text field to 5 lines
                decoration:
                    const InputDecoration(hintText: 'Type your comment'),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  widget.onComment(_commentController.text);
                  _commentController.clear();
                }
                Navigator.of(context).pop(); // Close the dialog after posting
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }
}

class Post {
  final String id;
  final String userId;
  final String username;
  final String userThumbnailUrl;
  final String text;
  final String? imageUrl;
  final DateTime timestamp;
  int likes;
  List<String> comments;

  Post({
    required this.id,
    required this.userId,
    required this.username,
    required this.userThumbnailUrl,
    required this.text,
    this.imageUrl,
    required this.timestamp,
    this.likes = 0,
    List<String>?
        comments, // This can now be passed as an argument to initialize the list
  }) : comments =
            comments ?? []; // Default to an empty list if none is provided

  void addComment(String comment) {
    comments.add(comment);
  }

  void toggleLike() {
    likes += 1;
  }
}
