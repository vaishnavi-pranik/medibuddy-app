import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/community_provider.dart';
import '../models/community_post.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommunityProvider>(context, listen: false).refreshPosts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Community',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF10B981),
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: const Color(0xFF10B981),
          tabs: const [
            Tab(text: 'Support Groups'),
            Tab(text: 'Success Stories'),
            Tab(text: 'Expert Sessions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSupportGroupsTab(),
          _buildSuccessStoriesTab(),
          _buildExpertSessionsTab(),
        ],
      ),
    );
  }

  Widget _buildSupportGroupsTab() {
    final supportGroups = [
      {
        'name': 'Skin Health Warriors',
        'status': 'Active',
        'category': 'Skin Problems',
        'description': 'A supportive community for those dealing with acne, eczema, psoriasis, and other skin conditions.',
        'members': 234,
        'lastActivity': '5 minutes ago',
      },
      {
        'name': 'Diabetes Support Circle',
        'status': 'Active',
        'category': 'Diabetes',
        'description': 'Managing diabetes together - share tips, recipes, and support each other\'s journey.',
        'members': 456,
        'lastActivity': '12 minutes ago',
      },
      {
        'name': 'PCOS Sisters',
        'status': 'Active',
        'category': 'PCOS',
        'description': 'A safe space for women with PCOS to share experiences and support each other.',
        'members': 189,
        'lastActivity': '23 minutes ago',
      },
      {
        'name': 'Mental Wellness Hub',
        'status': 'Active',
        'category': 'Mental Health',
        'description': 'Together we\'re stronger. A judgment-free zone for mental health support.',
        'members': 567,
        'lastActivity': '8 minutes ago',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: supportGroups.length,
      itemBuilder: (context, index) {
        final group = supportGroups[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        group['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        group['status'] as String,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  group['category'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  group['description'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${group['members']} members',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      group['lastActivity'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _joinSupportGroup(group['name'] as String),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Join Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccessStoriesTab() {
    final successStories = [
      {
        'title': 'My Journey to Clear Skin After 10 Years of Acne',
        'category': 'Skin Problems',
        'author': 'SkinWarrior23',
        'likes': 87,
        'content': 'After struggling with severe acne for over a decade, I finally found a routine that works in Indian climate. It wasn\'t easy - I tried countless products from local chemists, saw multiple dermatologists across Delhi, and even considered giving up. But persistence paid off! My current routine includes gentle cleansing with neem-based products, consistent use of tretinoin, and most importantly, stress management through yoga and meditation. The key was patience and not giving up. To anyone still struggling - your clear skin journey is possible! 💪',
        'tags': ['#acne', '#skincare', '#persistence', '#success', '#india'],
      },
      {
        'title': 'How I Reversed My Pre-Diabetes with Indian Diet',
        'category': 'Diabetes',
        'author': 'HealthyLiving2024',
        'likes': 156,
        'content': 'Six months ago, my doctor told me I was pre-diabetic. I was scared but determined to change. I started with small steps: morning walks in the local park, replacing white rice with brown rice and millets, cutting out sugary chai, and meal planning with traditional Indian foods like dal, sabzi, and roti. The support from this community was incredible! Everyone shared regional recipes, workout tips, and encouragement. My latest blood work shows normal glucose levels! The doctor was amazed. It\'s proof that our traditional diet, when balanced, really works. Thank you to everyone who supported me on this journey! 🎉',
        'tags': ['#pre-diabetes', '#lifestyle-change', '#exercise', '#indian-diet'],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: successStories.length,
      itemBuilder: (context, index) {
        final story = successStories[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      story['category'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'by ${story['author']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${story['likes']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  story['content'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: (story['tags'] as List<String>).map((tag) =>
                    Text(
                      tag,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpertSessionsTab() {
    final expertSessions = [
      {
        'title': 'Managing Acne: From Myths to Science-Based Solutions',
        'expert': 'Dr. Priya Sharma',
        'expertise': 'Dermatologist',
        'description': 'Join dermatologist Dr. Priya Sharma for an in-depth discussion about acne treatment, debunking common myths, and exploring the latest science-based approaches to clear skin.',
        'date': '2024-08-15',
        'time': '19:00',
        'duration': '60 minutes',
        'registered': 67,
        'maxCapacity': 100,
        'status': 'upcoming',
      },
      {
        'title': 'Diabetes Prevention and Management in India',
        'expert': 'Dr. Rajesh Gupta',
        'expertise': 'Endocrinologist',
        'description': 'Learn practical strategies for preventing and managing diabetes, including Indian diet tips, exercise recommendations, and monitoring techniques.',
        'date': '2024-08-12',
        'time': '18:30',
        'duration': '45 minutes',
        'registered': 89,
        'maxCapacity': 150,
        'status': 'upcoming',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: expertSessions.length,
      itemBuilder: (context, index) {
        final session = expertSessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'with ${session['expert']} • ${session['expertise']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  session['description'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${session['date']} at ${session['time']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      session['duration'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${session['registered']}/${session['maxCapacity']} registered',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        session['status'] as String,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _registerForSession(session['title'] as String),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Register for Session',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _joinSupportGroup(String groupName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joining $groupName...'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _registerForSession(String sessionTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registering for: $sessionTitle'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

  Widget _buildCommunityFeatures() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Community Features',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildFunctionalFeatureCard(
                  'Support Groups',
                  'Connect with others facing similar health challenges',
                  'Join Chat',
                  () => _joinSupportGroup(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFunctionalFeatureCard(
                  'Success Stories',
                  'Read inspiring health transformation journeys',
                  'Read Stories',
                  () => _viewSuccessStories(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFunctionalFeatureCard(
                  'Expert Sessions',
                  'Join live Q&A sessions with healthcare professionals',
                  'Join Session',
                  () => _joinExpertSession(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionalFeatureCard(String title, String description, String buttonText, VoidCallback onPressed) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              height: 1.3,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                padding: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(CommunityProvider provider) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('all', 'All', provider),
          ...provider.categories.map((category) =>
            _buildFilterChip(category.id, category.name, provider),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label, CommunityProvider provider) {
    final isSelected = provider.selectedFilter == filter;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => provider.setFilter(filter),
        selectedColor: const Color(0xFF10B981).withOpacity(0.2),
        checkmarkColor: const Color(0xFF10B981),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF10B981) : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPostCard(CommunityPost post, CommunityProvider provider) {
    final category = provider.getCategoryInfo(post.category);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: post.isExpert 
                      ? const Color(0xFF10B981) 
                      : Colors.grey[300],
                  radius: 18,
                  child: Icon(
                    post.isExpert ? Icons.verified : Icons.person,
                    color: post.isExpert ? Colors.white : Colors.grey[600],
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.authorName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (post.isExpert) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: Color(0xFF10B981),
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        _formatTimestamp(post.timestamp),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                if (category != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(int.parse(category.color)).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: Color(int.parse(category.color)),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Post title
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            
            // Post content
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            
            // Actions
            Row(
              children: [
                _buildActionButton(
                  Icons.thumb_up_outlined,
                  '${post.likes}',
                  () => provider.likePost(post.id),
                ),
                const SizedBox(width: 16),
                _buildActionButton(
                  Icons.comment_outlined,
                  '${post.comments}',
                  () {}, // TODO: Implement comments
                ),
                const Spacer(),
                _buildActionButton(
                  Icons.share_outlined,
                  'Share',
                  () {}, // TODO: Implement share
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _showCreatePostDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String selectedCategory = 'general';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'What\'s on your mind?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: Provider.of<CommunityProvider>(context, listen: false)
                    .categories
                    .map((category) => DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCategory = value;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (contentController.text.trim().isNotEmpty) {
                  await Provider.of<CommunityProvider>(context, listen: false)
                      .createPost(
                    authorId: 'current_user',
                    authorName: 'You',
                    content: contentController.text.trim(),
                    category: selectedCategory,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
              ),
              child: const Text('Post', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _joinSupportGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Support Groups'),
        content: const Text(
          'Welcome to our support groups! Here you can connect with others who share similar health journeys.\n\nAvailable Groups:\n• Diabetes Support\n• Mental Health Support\n• Weight Management\n• Chronic Pain Support',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Joined support group chat!'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
            child: const Text('Join Chat', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _viewSuccessStories() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success Stories'),
        content: const SingleChildScrollView(
          child: Text(
            'Inspiring Health Transformations:\n\n'
            '• "From 200 to 150 lbs: My Weight Loss Journey" - Sarah M.\n'
            '• "Managing Diabetes: 5 Years Strong" - Raj P.\n'
            '• "Overcoming Anxiety: My Mental Health Story" - Emma K.\n'
            '• "Living with Chronic Pain: Finding Hope" - Michael D.\n'
            '• "Heart Surgery Recovery: A New Life" - Linda T.\n\n'
            'Read how others overcame their health challenges and found their path to wellness.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening success stories...'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
            child: const Text('Read More', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _joinExpertSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Expert Sessions'),
        content: const Text(
          'Upcoming Expert Sessions:\n\n'
          '• "Managing Acne: From Myths to Science-Based Solutions"\n'
          '  with Dr. Priya Sharma • Dermatologist\n'
          '  Aug 15, 2024 at 7:00 PM • 60 minutes\n'
          '  67/100 registered\n\n'
          '• "Diabetes Prevention and Management in India"\n'
          '  with Dr. Rajesh Gupta • Endocrinologist\n'
          '  Aug 12, 2024 at 6:30 PM • 45 minutes\n'
          '  89/150 registered',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registered for expert session!'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
            child: const Text('Register', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
