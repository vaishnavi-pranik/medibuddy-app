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
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editProfile(),
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
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
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
                _buildInfoTile(Icons.person, 'Full Name', 'Vaishnavi Reddy'),
                _buildInfoTile(Icons.cake, 'Date of Birth', 'January 15, 1990'),
                _buildInfoTile(Icons.wc, 'Gender', 'Female'),
                _buildInfoTile(Icons.phone, 'Phone', '+91 9876543210'),
                _buildInfoTile(Icons.email, 'Email', 'vaishnavi.reddy@email.com'),
              ],
            ),

            const SizedBox(height: 24),

            // Health Information
            _buildSection(
              'Health Information',
              [
                _buildInfoTile(Icons.fitness_center, 'Weight', '70 kg'),
                _buildInfoTile(Icons.height, 'Height', '175 cm'),
                _buildInfoTile(Icons.bloodtype, 'Blood Group', 'O+'),
                _buildInfoTile(Icons.local_hospital, 'Allergies', 'None'),
                _buildInfoTile(Icons.medication, 'Current Medications', 'None'),
              ],
            ),

            const SizedBox(height: 24),

            // Emergency Contact
            _buildSection(
              'Emergency Contact',
              [
                _buildInfoTile(Icons.contact_emergency, 'Emergency Contact', 'Suresh Reddy'),
                _buildInfoTile(Icons.phone, 'Emergency Phone', '+91 9876543211'),
                _buildInfoTile(Icons.family_restroom, 'Relationship', 'Father'),
              ],
            ),

            const SizedBox(height: 24),

            // Settings
            _buildSection(
              'Settings',
              [
                _buildSettingsTile(Icons.notifications, 'Notifications', true),
                _buildSettingsTile(Icons.location_on, 'Location Services', true),
                _buildSettingsTile(Icons.dark_mode, 'Dark Mode', false),
              ],
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showHealthRecords(),
                    icon: const Icon(Icons.folder),
                    label: const Text('View Health Records'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _exportData(),
                    icon: const Icon(Icons.download),
                    label: const Text('Export Health Data'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _showPrivacySettings(),
                    icon: const Icon(Icons.privacy_tip),
                    label: const Text('Privacy Settings'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _logout(),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
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
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFF3B82F6)),
      onTap: () => _editField(title, subtitle),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, bool value) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
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
              leading: Icon(Icons.description),
              title: Text('Lab Reports'),
              subtitle: Text('3 recent reports'),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Prescriptions'),
              subtitle: Text('5 prescriptions'),
            ),
            ListTile(
              leading: Icon(Icons.vaccines),
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
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text('Account Visibility'),
              subtitle: Text('Manage who can see your profile'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text('Delete Account'),
              subtitle: Text('Permanently delete your account'),
              trailing: Icon(Icons.chevron_right),
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
