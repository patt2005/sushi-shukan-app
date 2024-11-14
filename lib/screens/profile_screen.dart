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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool isEditingName = false;

  String? editingField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<AppProvider>(
            builder: (context, value, child) => Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
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
                        onTap: () async {
                          final imagePicker = ImagePicker();
                          final image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            final cacheDir = await getTemporaryDirectory();
                            final timestamp = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            final filePath = path.join(cacheDir.path,
                                'profile_picture_$timestamp.png');
                            final newFile = File(filePath);

                            if (await newFile.exists()) {
                              await newFile.delete();
                            }

                            await File(image.path).copy(filePath);
                            setState(() {
                              _profileImagePath = filePath;
                            });
                          }
                        },
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
                ),
                const SizedBox(height: 20),
                GestureDetector(
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
                          controller:
                              TextEditingController(text: value.user.name),
                          onSubmitted: (text) {
                            setState(() {
                              value.setUserName(text);
                              isEditingName = false;
                            });
                          },
                        )
                      : Text(
                          value.user.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          ),
                        ),
                ),
                const SizedBox(height: 30),
                Container(
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
                      _buildEditableListTile(
                        icon: Icons.email,
                        title: "Email",
                        value: value.user.email,
                        editingField: editingField,
                        controller: _emailController,
                        onSubmitted: (emailText) {
                          setState(() {
                            value.setEmail(emailText);
                            editingField = null;
                          });
                        },
                        onTap: () => setState(() {
                          editingField = "email";
                        }),
                      ),
                      _divider(),
                      _buildEditableListTile(
                        icon: Icons.phone,
                        title: "Phone",
                        value: value.user.phoneNumber,
                        editingField: editingField,
                        controller: _phoneController,
                        onSubmitted: (phone) {
                          setState(() {
                            value.setPhoneNumber(phone);
                            editingField = null;
                          });
                        },
                        onTap: () => setState(() {
                          editingField = "phone";
                        }),
                      ),
                      _divider(),
                      _buildEditableListTile(
                        icon: Icons.location_on,
                        title: "Location",
                        value: value.user.location,
                        editingField: editingField,
                        controller: _locationController,
                        onSubmitted: (loc) {
                          setState(() {
                            value.setUserLocation(loc);
                            editingField = null;
                          });
                        },
                        onTap: () => setState(() {
                          editingField = "location";
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey,
    );
  }

  Widget _buildEditableListTile({
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
}
