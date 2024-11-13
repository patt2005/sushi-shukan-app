import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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

  String name = "John Doe";
  bool isEditingName = false;

  String email = "johndoe@example.com";
  String phone = "+123 456 7890";
  String location = "New York City, NY";

  String? editingField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 33,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : null,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black54,
                    ),
                    onPressed: () async {
                      final imagePicker = ImagePicker();
                      final image = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null) {
                        final cacheDir = await getTemporaryDirectory();
                        final timestamp =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        final filePath = path.join(
                            cacheDir.path, 'profile_picture_$timestamp.png');
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
                  ),
                ),
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
                        controller: TextEditingController(text: name),
                        onSubmitted: (value) {
                          setState(() {
                            name = value.isNotEmpty ? value : name;
                            isEditingName = false;
                          });
                        },
                      )
                    : Text(
                        name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: editingField == "email"
                          ? TextField(
                              controller: _emailController,
                              onSubmitted: (value) {
                                setState(() {
                                  email = value;
                                  editingField = null;
                                });
                              },
                            )
                          : Text(email),
                      onTap: () {
                        setState(() {
                          editingField = "email";
                        });
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Phone'),
                      subtitle: editingField == "phone"
                          ? TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              onSubmitted: (value) {
                                setState(() {
                                  phone = value;
                                  editingField = null;
                                });
                              },
                            )
                          : Text(phone),
                      onTap: () {
                        setState(() {
                          editingField = "phone";
                        });
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Location'),
                      subtitle: editingField == "location"
                          ? TextField(
                              controller: _locationController,
                              onSubmitted: (value) {
                                setState(() {
                                  location = value;
                                  editingField = null;
                                });
                              },
                            )
                          : Text(location),
                      onTap: () {
                        setState(() {
                          editingField = "location";
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
