class CommunityPost {
  final String id;
  final String authorName;
  final String title;
  final String content;
  final DateTime timestamp;
  final DateTime createdAt;
  final int likes;
  final int comments;
  final String category;
  final List<String>? imageUrls;
  final bool isLiked;

  CommunityPost({
    required this.id,
    required this.authorName,
    required this.title,
    required this.content,
    required this.timestamp,
    DateTime? createdAt,
    this.likes = 0,
    this.comments = 0,
    required this.category,
    this.imageUrls,
    this.isLiked = false,
  }) : createdAt = createdAt ?? timestamp;

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      title: json['title'] as String? ?? '',
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.parse(json['timestamp'] as String),
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      category: json['category'] as String,
      imageUrls: json['imageUrls'] != null 
          ? List<String>.from(json['imageUrls'] as List)
          : null,
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'title': title,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
      'comments': comments,
      'category': category,
      'imageUrls': imageUrls,
      'isLiked': isLiked,
    };
  }

  CommunityPost copyWith({
    String? id,
    String? authorName,
    String? title,
    String? content,
    DateTime? timestamp,
    DateTime? createdAt,
    int? likes,
    int? comments,
    String? category,
    List<String>? imageUrls,
    bool? isLiked,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      category: category ?? this.category,
      imageUrls: imageUrls ?? this.imageUrls,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
