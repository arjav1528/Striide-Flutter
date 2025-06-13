import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';
import 'package:striide_flutter/features/feedback/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:striide_flutter/core/utils/permission_utils.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  int _starRating = 0;
  FeedbackCategory? _selectedCategory;
  bool? _allowContact;
  bool _isSubmitting = false;
  final List<String> _mediaFiles = [];
  final List<XFile> _pickedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Add listener to text controller for real-time validation
    _feedbackController.addListener(() {
      setState(() {}); // Rebuild to update button state
    });
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _starRating > 0 &&
        _selectedCategory != null &&
        _feedbackController.text.trim().isNotEmpty &&
        _allowContact != null;
  }

  Future<void> _handleSubmit() async {
    if (!_isFormValid || _isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      print('🎬 Starting feedback submission...');

      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      print('👤 User: ${user?.id ?? 'null'}');

      if (user == null) throw Exception('User not logged in');

      print('📷 Images to upload: ${_pickedImages.length}');

      // Upload images to Supabase storage (for archival purposes, not stored in DB)
      if (_pickedImages.isNotEmpty) {
        await _uploadImages(_pickedImages);
      }

      final now = DateTime.now().toUtc().toIso8601String();

      print('💾 Saving to database...');

      // Insert feedback into database
      await supabase.from('feedback').insert({
        'user_id': user.id,
        'star_rating': _starRating,
        'category': _selectedCategory?.name,
        'message': _feedbackController.text.trim(),
        'allow_contact': _allowContact,
        'created_at': now,
      });

      print('✅ Feedback saved successfully!');

      // Pop the feedback screen first
      if (mounted) {
        Navigator.of(context).pop();

        // Then show success dialog
        Future.delayed(const Duration(milliseconds: 200), () {
          if (context.mounted) {
            showFeedbackSuccessDialog(context);
          }
        });

        // Clear form after successful submission
        _clearForm();
      }
    } catch (error) {
      print('❌ Error submitting feedback: $error');

      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit feedback: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _clearForm() {
    setState(() {
      _starRating = 0;
      _selectedCategory = null;
      _allowContact = null;
      _mediaFiles.clear();
      _pickedImages.clear();
    });
    _feedbackController.clear();
  }

  Future<void> _handleAddMedia() async {
    // Request media permission using the new method
    final hasPermission = await PermissionUtils.requestMediaPermission(context);

    if (!hasPermission) return;

    try {
      final picked = await _picker.pickMultiImage();

      if (picked.isNotEmpty) {
        setState(() {
          _pickedImages.addAll(picked);
          _mediaFiles.addAll(picked.map((img) => path.basename(img.path)));
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${picked.length} image(s)'),
            backgroundColor: const Color(0xFFff7a4b),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking images: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _removeMedia(int index) {
    setState(() {
      _mediaFiles.removeAt(index);
      _pickedImages.removeAt(index);
    });
  }

  Future<void> _uploadImages(List<XFile> images) async {
    final supabase = Supabase.instance.client;

    print('🚀 Starting upload of ${images.length} images...');

    for (final image in images) {
      try {
        print('📸 Processing image: ${image.path}');
        final fileBytes = await image.readAsBytes();
        final fileName = '${const Uuid().v4()}${path.extension(image.path)}';

        print('📤 Uploading $fileName to feedback-files bucket...');

        await supabase.storage
            .from('feedback-files')
            .uploadBinary(
              fileName,
              fileBytes,
              fileOptions: const FileOptions(contentType: 'image/png'),
            );

        print('✅ Upload successful for $fileName');
      } catch (e) {
        // Log error but continue with other images
        print('❌ Error uploading image: $e');
      }
    }

    print('🎯 Upload complete');
  }

  @override
  Widget build(BuildContext context) {
    UIUtils.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292732),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UIUtils.verticalSpace32,
              // Header Section
              const FeedbackHeaderWidget(),

              UIUtils.verticalSpace32,

              // Star Rating Section
              StarRatingWidget(
                currentRating: _starRating,
                onRatingChanged: (rating) {
                  setState(() {
                    _starRating = rating;
                  });
                },
              ),

              UIUtils.verticalSpace32,

              // "How are you liking Striide?" text
              const Text(
                'How are you liking Striide?',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontSize: 16,
                ),
              ),

              UIUtils.verticalSpace32,

              // Category Selection
              Padding(
                padding: UIUtils.horizontalPadding24,
                child: FeedbackCategoryWidget(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              ),

              UIUtils.verticalSpace32,

              // Feedback Text Field
              Padding(
                padding: UIUtils.horizontalPadding24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeedbackTextFieldWidget(
                      controller: _feedbackController,
                      onAddMedia: _handleAddMedia,
                    ),
                    if (_mediaFiles.isNotEmpty) ...[
                      UIUtils.verticalSpace12,
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3a3a42),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Attached Media (${_mediaFiles.length})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            UIUtils.verticalSpace8,
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  _mediaFiles.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    String fileName = entry.value;
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFff7a4b,
                                        ).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: const Color(0xFFff7a4b),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.attach_file,
                                            size: 14,
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            fileName,
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(
                                                0.8,
                                              ),
                                              fontSize: 12,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          GestureDetector(
                                            onTap: () => _removeMedia(index),
                                            child: Icon(
                                              Icons.close,
                                              size: 14,
                                              color: Colors.white.withOpacity(
                                                0.8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              UIUtils.verticalSpace32,

              // Contact Permission
              Padding(
                padding: UIUtils.horizontalPadding24,
                child: ContactPermissionWidget(
                  allowContact: _allowContact,
                  onPermissionChanged: (allow) {
                    setState(() {
                      _allowContact = allow;
                    });
                  },
                ),
              ),

              UIUtils.verticalSpace(48),

              // Submit Button
              FeedbackSubmitButtonWidget(
                onSubmit: _handleSubmit,
                isEnabled: _isFormValid && !_isSubmitting,
                text: _isSubmitting ? 'Submitting...' : 'Submit',
              ),

              UIUtils.verticalSpace32,
            ],
          ),
        ),
      ),
    );
  }
}
