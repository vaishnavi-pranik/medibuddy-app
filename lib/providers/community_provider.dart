import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/community_post.dart';

class CommunityProvider with ChangeNotifier {
  final List<CommunityPost> _posts = [];
  bool _isLoading = false;

  List<CommunityPost> get posts => _posts;
  bool get isLoading => _isLoading;

  static const String _postsKey = 'community_posts';

  CommunityProvider() {
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final postsData = prefs.getString(_postsKey);
      
      if (postsData != null) {
        final postsList = jsonDecode(postsData) as List;
        _posts.clear();
        _posts.addAll(
          postsList.map((postData) => CommunityPost.fromJson(postData)).toList(),
        );
      } else {
        // Initialize with sample posts
        await _initializeSamplePosts();
      }
    } catch (e) {
      print('Error loading posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _initializeSamplePosts() async {
    final samplePosts = [
      CommunityPost(
        id: '1',
        authorName: 'Priya Sharma',
        title: '30-Day Fitness Challenge Complete!',
        content: 'Just completed my 30-day fitness challenge! Feeling amazing and more energetic than ever. Small steps really do make a big difference! 💪',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        likes: 24,
        comments: 8,
        category: 'success',
      ),
      CommunityPost(
        id: '2',
        authorName: 'Rajesh Kumar',
        title: 'Healthy Indian Breakfast Recipes?',
        content: 'Looking for healthy Indian breakfast recipes for diabetic patients. Any suggestions from the community? Thanks in advance!',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        likes: 12,
        comments: 15,
        category: 'support',
      ),
      CommunityPost(
        id: '3',
        authorName: 'Dr. Anita Nair',
        title: 'Weekly Wellness Reminder',
        content: 'Weekly reminder: Don\'t forget to take your vitamins and stay hydrated! Your body will thank you later. 💊💧',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        likes: 35,
        comments: 5,
        category: 'expert',
      ),
      CommunityPost(
        id: '4',
        authorName: 'Vikram Singh',
        title: 'Meditation Changed My Life',
        content: 'Meditation has changed my life! Started with just 5 minutes a day and now I can\'t imagine my routine without it. Mental health matters! 🧘‍♂️',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        likes: 18,
        comments: 12,
        category: 'support',
      ),
    ];

    _posts.addAll(samplePosts);
    await _savePosts();
  }

  Future<void> _savePosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsJson = _posts.map((post) => post.toJson()).toList();
      await prefs.setString(_postsKey, jsonEncode(postsJson));
    } catch (e) {
      print('Error saving posts: $e');
    }
  }

  Future<void> addPost(String title, String content, String category) async {
    final newPost = CommunityPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: 'You', // In a real app, this would be the current user's name
      title: title,
      content: content,
      timestamp: DateTime.now(),
      likes: 0,
      comments: 0,
      category: category,
    );

    _posts.insert(0, newPost);
    notifyListeners();
    await _savePosts();
  }

  Future<void> toggleLike(String postId) async {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = _posts[postIndex];
      _posts[postIndex] = post.copyWith(
        isLiked: !post.isLiked,
        likes: post.isLiked ? post.likes - 1 : post.likes + 1,
      );
      notifyListeners();
      await _savePosts();
    }
  }

  Future<void> likePost(String postId) async {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      _posts[postIndex] = _posts[postIndex].copyWith(
        likes: _posts[postIndex].likes + 1,
      );
      notifyListeners();
      await _savePosts();
    }
  }

  Future<void> refreshPosts() async {
    await _loadPosts();
  }

  List<CommunityPost> getPostsByCategory(String category) {
    return _posts.where((post) => post.category == category).toList();
  }
}
