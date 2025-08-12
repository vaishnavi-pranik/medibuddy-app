import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/community_provider.dart';

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Groups'),
            Tab(text: 'Stories'),
            Tab(text: 'Sessions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSupportGroups(),
          _buildSuccessStories(),
          _buildExpertSessions(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(),
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSupportGroups() {
    final groups = [
      {
        'name': 'Skin Health Warriors',
        'status': 'Active',
        'category': 'Skin Problems',
        'description': 'A supportive community for those dealing with acne, eczema, psoriasis, and other skin conditions.',
        'members': '234 members',
        'lastActive': '5 minutes ago',
      },
      {
        'name': 'Diabetes Support Circle',
        'status': 'Active',
        'category': 'Diabetes',
        'description': 'Managing diabetes together - share tips, recipes, and support each other\'s journey.',
        'members': '456 members',
        'lastActive': '12 minutes ago',
      },
      {
        'name': 'PCOS Sisters',
        'status': 'Active',
        'category': 'PCOS',
        'description': 'A safe space for women with PCOS to share experiences and support each other.',
        'members': '189 members',
        'lastActive': '23 minutes ago',
      },
      {
        'name': 'Mental Wellness Hub',
        'status': 'Active',
        'category': 'Mental Health',
        'description': 'Together we\'re stronger. A judgment-free zone for mental health support.',
        'members': '567 members',
        'lastActive': '8 minutes ago',
      },
      {
        'name': 'Post-Surgery Recovery',
        'status': 'Active',
        'category': 'Recent Surgery',
        'description': 'Healing together - support for those recovering from various surgical procedures.',
        'members': '123 members',
        'lastActive': '45 minutes ago',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: const Color(0xFFF0F8FF), // Light blue background
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        group['name']! as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        group['status']! as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    group['category']! as String,
                    style: const TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  group['description']! as String,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      group['members']! as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      group['lastActive']! as String,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _openGroupChat(group['name'] as String),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Join Chat'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccessStories() {
    final stories = [
      {
        'title': 'My Journey to Clear Skin After 10 Years of Acne',
        'category': 'Skin Problems',
        'author': 'SkinWarrior23',
        'likes': '87',
        'content': 'After struggling with severe acne for over a decade, I finally found a routine that works in Indian climate. It wasn\'t easy - I tried countless products from local chemists, saw multiple dermatologists across Delhi, and even considered giving up. But persistence paid off! My current routine includes gentle cleansing with neem-based products, consistent use of tretinoin, and most importantly, stress management through yoga and meditation. The key was patience and not giving up. To anyone still struggling - your clear skin journey is possible! 💪',
        'fullContent': 'After struggling with severe acne for over a decade, I finally found a routine that works in Indian climate. It wasn\'t easy - I tried countless products from local chemists, saw multiple dermatologists across Delhi, and even considered giving up. But persistence paid off!\n\nMy current routine includes:\n• Gentle cleansing with neem-based products twice daily\n• Consistent use of tretinoin (started with 0.025%, now using 0.05%)\n• Weekly clay masks with multani mitti\n• Daily sunscreen (non-comedogenic, SPF 30+)\n• Stress management through yoga and meditation\n• Proper sleep schedule (7-8 hours)\n• Drinking plenty of water and avoiding dairy\n\nThe key was patience and not giving up. It took almost 8 months to see significant results, but now my skin is clearer than ever. To anyone still struggling - your clear skin journey is possible! Remember, what works for one person might not work for another, so be patient and work with a good dermatologist.',
        'tags': ['#acne', '#skincare', '#persistence', '#success', '#india'],
      },
      {
        'title': 'Beating Diabetes: My 2-Year Transformation',
        'category': 'Diabetes',
        'author': 'HealthyLife42',
        'likes': '152',
        'content': 'Two years ago, I was diagnosed with Type 2 diabetes. My HbA1c was 9.2, and I was scared. Today, it\'s 6.1 and I feel amazing! Here\'s how I turned my life around with diet, exercise, and mindset changes...',
        'fullContent': 'Two years ago, I was diagnosed with Type 2 diabetes. My HbA1c was 9.2, and I was scared. Today, it\'s 6.1 and I feel amazing!\n\nMy transformation journey:\n• Completely changed my diet - focused on low-carb, high-fiber foods\n• Started with 15-minute walks, now I do 45-minute daily workouts\n• Learned to read food labels and count carbs\n• Found diabetes-friendly Indian recipes\n• Regular monitoring with glucometer\n• Lost 25 kg in 18 months\n• Joined a diabetes support group\n\nThe hardest part was giving up rice and sweets during festivals, but I found healthier alternatives. My family was incredibly supportive. Now I help others in my community understand diabetes management.',
        'tags': ['#diabetes', '#weightloss', '#healthyeating', '#transformation'],
      },
      {
        'title': 'From Anxiety to Peace: My Mental Health Journey',
        'category': 'Mental Health',
        'author': 'PeacefulMind',
        'likes': '203',
        'content': 'For years, I suffered from severe anxiety and panic attacks. I was afraid to leave my house, couldn\'t focus at work, and felt like I was drowning. But with therapy, medication, and lifestyle changes, I found my way back to peace...',
        'fullContent': 'For years, I suffered from severe anxiety and panic attacks. I was afraid to leave my house, couldn\'t focus at work, and felt like I was drowning.\n\nWhat helped me:\n• Found a great therapist who specialized in anxiety disorders\n• Started medication (took time to find the right one)\n• Practiced daily meditation and breathing exercises\n• Regular exercise - even 20 minutes of walking helped\n• Limited caffeine and alcohol\n• Joined a support group\n• Learned to identify triggers\n• Developed healthy coping mechanisms\n\nRecovery isn\'t linear - I still have difficult days, but now I have tools to handle them. If you\'re struggling, please reach out for help. You\'re not alone, and it does get better.',
        'tags': ['#mentalhealth', '#anxiety', '#therapy', '#recovery', '#selfcare'],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stories.length,
      itemBuilder: (context, index) {
        final story = stories[index];
        return GestureDetector(
          onTap: () => _openStoryDetail(story),
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: const Color(0xFFF0F8FF), // Light blue background
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story['title']! as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF3B82F6).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          story['category']! as String,
                          style: const TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'by ${story['author']! as String}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    story['content']! as String,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: (story['tags']! as List<String>).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Spacer(),
                      // Removed thumbs up/down buttons for cleaner UI
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpertSessions() {
    final sessions = [
      {
        'title': 'Managing Acne: From Myths to Science-Based Solutions',
        'expert': 'Dr. Priya Sharma',
        'specialty': 'Dermatologist',
        'description': 'Join dermatologist Dr. Priya Sharma for an in-depth discussion about acne treatment, debunking common myths, and exploring the latest science-based approaches to clear skin.',
        'date': '2024-08-15 at 19:00',
        'duration': '60 minutes',
        'registered': '67/100 registered',
        'status': 'upcoming',
      },
      {
        'title': 'Diabetes Prevention and Management in India',
        'expert': 'Dr. Rajesh Gupta',
        'specialty': 'Endocrinologist',
        'description': 'Learn practical strategies for preventing and managing diabetes, including Indian diet tips, exercise recommendations, and monitoring techniques.',
        'date': '2024-08-12 at 18:30',
        'duration': '45 minutes',
        'registered': '89/150 registered',
        'status': 'upcoming',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: const Color(0xFFF0F8FF), // Light blue background
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session['title']! as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'with ${session['expert']! as String} • ${session['specialty']! as String}',
                      style: const TextStyle(
                        color: Color(0xFF3B82F6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  session['description']! as String,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF3B82F6).withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.schedule, color: Color(0xFF3B82F6), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            session['date']! as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Color(0xFF3B82F6), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            session['duration']! as String,
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            session['registered']! as String,
                            style: const TextStyle(
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        session['status']! as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _showRegistrationDialog(session['title']! as String),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Register for Session'),
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

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Post'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add post creation logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
            ),
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  void _openGroupChat(String groupName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupChatScreen(groupName: groupName),
      ),
    );
  }

  void _openStoryDetail(Map<String, dynamic> story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryDetailScreen(story: story),
      ),
    );
  }

  void _showRegistrationDialog(String sessionTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Successful!'),
        content: Text(
          'You have successfully registered for "$sessionTitle". You will receive a confirmation email shortly.',
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// Group Chat Screen
class GroupChatScreen extends StatelessWidget {
  final String groupName;
  
  const GroupChatScreen({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    final sampleMessages = [
      {'sender': 'Dr. Sarah', 'message': 'Welcome to the $groupName! Feel free to share your experiences and ask questions.', 'time': '10:30 AM', 'isDoctor': true},
      {'sender': 'Alex_23', 'message': 'Hi everyone! I\'m new here and looking forward to connecting with you all.', 'time': '10:32 AM', 'isDoctor': false},
      {'sender': 'HealthyMom', 'message': 'Alex welcome! This group has been so helpful for me. Don\'t hesitate to ask anything.', 'time': '10:35 AM', 'isDoctor': false},
      {'sender': 'WellnessGuru', 'message': 'Has anyone tried the new treatment that was discussed last week?', 'time': '10:40 AM', 'isDoctor': false},
      {'sender': 'Dr. Sarah', 'message': 'Great question! I can share some insights about that treatment. Let me know if you have specific questions.', 'time': '10:42 AM', 'isDoctor': true},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sampleMessages.length,
              itemBuilder: (context, index) {
                final message = sampleMessages[index];
                final isDoctor = message['isDoctor'] as bool;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isDoctor ? const Color(0xFF3B82F6) : Colors.grey[300],
                        child: Text(
                          (message['sender'] as String)[0],
                          style: TextStyle(
                            color: isDoctor ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F8FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF3B82F6).withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    message['sender'] as String,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDoctor ? const Color(0xFF3B82F6) : Colors.black87,
                                    ),
                                  ),
                                  if (isDoctor) ...[
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.verified,
                                      size: 16,
                                      color: Color(0xFF3B82F6),
                                    ),
                                  ],
                                  const Spacer(),
                                  Text(
                                    message['time'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message['message'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF3B82F6),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Story Detail Screen
class StoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> story;
  
  const StoryDetailScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Story'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              story['title'] as String,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    story['category'] as String,
                    style: const TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'by ${story['author'] as String}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              story['fullContent'] as String,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (story['tags'] as List<String>).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Removed thumbs up/down buttons for cleaner UI
          ],
        ),
      ),
    );
  }
}
