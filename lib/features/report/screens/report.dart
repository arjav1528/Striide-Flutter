import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';
import 'package:striide_flutter/features/report/widgets/widgets.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:striide_flutter/core/utils/permission_utils.dart';

class ReportScreen extends StatefulWidget {
  final mp.Position initialPosition;
  const ReportScreen({super.key, required this.initialPosition});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _reportController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isSubmitting = false;
  final List<String> _mediaFiles = [];
  final List<XFile> _pickedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Add listener to text controller for real-time validation
    _reportController.addListener(() {
      setState(() {}); // Rebuild to update button state
    });

    // Set the location controller text to the initial position coordinates
    _locationController.text =
        '${widget.initialPosition.lat.toStringAsFixed(6)}, ${widget.initialPosition.lng.toStringAsFixed(6)}';
  }

  @override
  void dispose() {
    _reportController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _reportController.text.trim().isNotEmpty;
  }

  Future<void> _handleSubmit() async {
    if (!_isFormValid || _isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('User not logged in');
      final imageUrls = await _uploadImages(_pickedImages);
      final now = DateTime.now().toUtc().toIso8601String();
      await supabase.from('reports').insert({
        'user_id': user.id,
        'description': _reportController.text.trim(),
        'media_urls': imageUrls,
        'location': _locationController.text.trim(),
        'created_at': now,
      });
      if (mounted) {
        Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 200), () {
          if (context.mounted) {
            showReportSuccessDialog(context);
          }
        });
        _clearForm();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit report: $error'),
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
      _mediaFiles.clear();
      _pickedImages.clear();
    });
    _reportController.clear();
    _locationController.clear();
  }

  Future<void> _handleAddMedia() async {
    // Request media permission using the new method
    final hasPermission = await PermissionUtils.requestMediaPermission(context);
    if (!hasPermission) return;

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
  }

  void _removeMedia(int index) {
    setState(() {
      _mediaFiles.removeAt(index);
      _pickedImages.removeAt(index);
    });
  }

  Future<List<String>> _uploadImages(List<XFile> images) async {
    final supabase = Supabase.instance.client;
    final List<String> urls = [];

    print('🚀 Starting upload of ${images.length} report images...');

    for (final image in images) {
      try {
        print('📸 Processing report image: ${image.path}');
        final fileBytes = await image.readAsBytes();
        final fileName = '${const Uuid().v4()}${path.extension(image.path)}';

        print('📤 Uploading $fileName to report-media-files bucket...');

        await supabase.storage
            .from('report-media-files')
            .uploadBinary(
              fileName,
              fileBytes,
              fileOptions: const FileOptions(contentType: 'image/png'),
            );

        print('✅ Upload successful for $fileName');

        final publicUrl = supabase.storage
            .from('report-media-files')
            .getPublicUrl(fileName);

        urls.add(publicUrl);
        print('🔗 Generated URL: $publicUrl');
      } catch (e) {
        print('❌ Error uploading report image: $e');
      }
    }

    print('🎯 Report upload complete. Generated ${urls.length} URLs');
    return urls;
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
              const ReportHeaderWidget(),

              UIUtils.verticalSpace32,

              // Location Input
              Padding(
                padding: UIUtils.horizontalPadding24,
                child: LocationInputWidget(controller: _locationController),
              ),

              UIUtils.verticalSpace32,

              // Report Text Field
              Padding(
                padding: UIUtils.horizontalPadding24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportTextFieldWidget(
                      controller: _reportController,
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

              UIUtils.verticalSpace(48),

              // Submit Button
              ReportSubmitButtonWidget(
                onSubmit: _handleSubmit,
                isEnabled: _isFormValid && !_isSubmitting,
                text: _isSubmitting ? 'Submitting...' : 'Submit report',
              ),

              UIUtils.verticalSpace32,
            ],
          ),
        ),
      ),
    );
  }
}
