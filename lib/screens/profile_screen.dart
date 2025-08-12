import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () => _editProfile(),
            child: const Text('Edit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF3B82F6),
                    child: Text(
                      'VR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Vaishnavi Reddy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'vaishnavi.reddy@email.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profile Information
            _buildSection(
              'Personal Information',
              [
                _buildInfoTile('Full Name', 'Vaishnavi Reddy'),
                _buildInfoTile('Date of Birth', 'January 15, 1990'),
                _buildInfoTile('Gender', 'Female'),
                _buildInfoTile('Phone', '+91 9876543210'),
                _buildInfoTile('Email', 'vaishnavi.reddy@email.com'),
              ],
            ),

            const SizedBox(height: 24),

            // Health Information
            _buildSection(
              'Health Information',
              [
                _buildInfoTile('Weight', '70 kg'),
                _buildInfoTile('Height', '175 cm'),
                _buildInfoTile('Blood Group', 'O+'),
                _buildInfoTile('Allergies', 'None'),
                _buildInfoTile('Current Medications', 'None'),
              ],
            ),

            const SizedBox(height: 24),

            // Emergency Contact
            _buildSection(
              'Emergency Contact',
              [
                _buildInfoTile('Emergency Contact', 'Suresh Reddy'),
                _buildInfoTile('Emergency Phone', '+91 9876543211'),
                _buildInfoTile('Relationship', 'Father'),
              ],
            ),

            const SizedBox(height: 24),

            // Settings
            _buildSection(
              'Settings',
              [
                _buildSettingsTile('Notifications', true),
                _buildSettingsTile('Location Services', true),
                _buildSettingsTile('Dark Mode', false),
              ],
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showHealthRecords(),
                    child: const Text('View Health Records'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _exportData(),
                    child: const Text('Export Health Data'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _showPrivacySettings(),
                    child: const Text('Privacy Settings'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _logout(),
                    child: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFF0F8FF), // Light blue background
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () => _editField(title, subtitle),
    );
  }

  Widget _buildSettingsTile(String title, bool value) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        activeColor: const Color(0xFF3B82F6),
        onChanged: (newValue) => _toggleSetting(title, newValue),
      ),
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editField(String field, String currentValue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: TextEditingController(text: currentValue),
          decoration: InputDecoration(
            labelText: field,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _toggleSetting(String setting, bool value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$setting ${value ? "enabled" : "disabled"}')),
    );
  }

  void _showHealthRecords() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Health Records'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Lab Reports'),
              subtitle: Text('3 recent reports'),
            ),
            ListTile(
              title: Text('Prescriptions'),
              subtitle: Text('5 prescriptions'),
            ),
            ListTile(
              title: Text('Vaccination Records'),
              subtitle: Text('Up to date'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Health data export initiated')),
    );
  }

  void _showPrivacySettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Data Sharing'),
              subtitle: Text('Control how your data is shared'),
            ),
            ListTile(
              title: Text('Account Visibility'),
              subtitle: Text('Manage who can see your profile'),
            ),
            ListTile(
              title: Text('Delete Account'),
              subtitle: Text('Permanently delete your account'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
