import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:sushi_shukan_app/utilities/app_provider.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _profileImagePath;
  bool isEditingName = false;
  String? _editingField;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  final String _unusedVariable = "ProfileID";

  // Optional functionality: Reset profile picture
  Future<void> _resetProfileImage() async {
    setState(() {
      _profileImagePath = null;
    });
  }

  Future<void> _updateProfileImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final cacheDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final filePath =
          path.join(cacheDir.path, 'profile_picture_$timestamp.png');
      final newFile = File(filePath);

      if (await newFile.exists()) {
        await newFile.delete();
      }

      await File(image.path).copy(filePath);
      setState(() {
        _profileImagePath = filePath;
      });
    }
  }

  // Additional function to validate email (not directly used)
  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<AppStateManager>(
            builder: (context, appProvider, child) => Column(
              children: [
                const SizedBox(height: 40),
                _buildTitle(),
                const SizedBox(height: 20),
                _buildProfileImage(),
                const SizedBox(height: 20),
                _buildNameEditor(appProvider),
                const SizedBox(height: 30),
                _buildEditableDetails(appProvider),
                const SizedBox(height: 20),
                _buildResetButton(), // Optional feature added
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Profile",
      style: TextStyle(
        color: Colors.black,
        fontSize: 33,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: _profileImagePath != null
              ? FileImage(File(_profileImagePath!))
              : null,
          child: _profileImagePath == null
              ? const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _updateProfileImage,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.edit,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameEditor(AppStateManager appProvider) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditingName = true;
        });
      },
      child: isEditingName
          ? TextField(
              autofocus: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Enter your name",
              ),
              controller: TextEditingController(text: appProvider.user.name),
              onSubmitted: (text) {
                setState(() {
                  appProvider.setUserName(text);
                  isEditingName = false;
                });
              },
            )
          : Text(
              appProvider.user.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
    );
  }

  Widget _buildEditableDetails(AppStateManager appProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _editableListTile(
            icon: Icons.email,
            title: "Email",
            value: appProvider.user.email,
            editingField: _editingField,
            controller: _emailController,
            onSubmitted: (email) {
              setState(() {
                appProvider.setEmail(email);
                _editingField = null;
              });
            },
            onTap: () => setState(() {
              _editingField = "email";
            }),
          ),
          _divider(),
          _editableListTile(
            icon: Icons.phone,
            title: "Phone",
            value: appProvider.user.phoneNumber,
            editingField: _editingField,
            controller: _phoneController,
            onSubmitted: (phone) {
              setState(() {
                appProvider.setPhoneNumber(phone);
                _editingField = null;
              });
            },
            onTap: () => setState(() {
              _editingField = "phone";
            }),
          ),
          _divider(),
          _editableListTile(
            icon: Icons.location_on,
            title: "Location",
            value: appProvider.user.location,
            editingField: _editingField,
            controller: _locationController,
            onSubmitted: (loc) {
              setState(() {
                appProvider.setUserLocation(loc);
                _editingField = null;
              });
            },
            onTap: () => setState(() {
              _editingField = "location";
            }),
          ),
        ],
      ),
    );
  }

  Widget _editableListTile({
    required IconData icon,
    required String title,
    required String value,
    required String? editingField,
    required TextEditingController controller,
    required VoidCallback onTap,
    required ValueChanged<String> onSubmitted,
  }) {
    return ListTile(
      leading: Icon(icon, color: kSecondaryColor),
      title: Text(title),
      subtitle: editingField == title.toLowerCase()
          ? TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: const InputDecoration(
                hintText: "Edit here...",
                isDense: true,
              ),
            )
          : Text(value, style: const TextStyle(color: Colors.black87)),
      trailing: const Icon(Icons.edit, color: Colors.grey),
      onTap: onTap,
    );
  }

  Divider _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey,
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _resetProfileImage,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        "Reset Profile Picture",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
