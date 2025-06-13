import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingProvider extends ChangeNotifier {
  // Profile 1 data (private information)
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  String _selectedGender = '';
  DateTime? _selectedDate;
  bool _termsAccepted = false;

  // Profile 2 data (public information)
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  String _selectedPronouns = '';

  // Bio expansion data
  final List<TextEditingController> cityControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<String> selectedEmojis = ['🏠', '📊', '💼'];

  // Form validation states
  bool _isProfile1Valid = false;
  bool _isProfile2Valid = false;
  bool _isLoading = false;

  // Gender and pronoun options
  final List<String> genders = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  final List<String> pronounOptions = [
    'she/her',
    'they/them',
    'he/him',
    'she/they',
    'he/they',
    'other',
  ];

  final List<String> availableEmojis = [
    '🏠',
    '🏢',
    '🏙️',
    '🌆',
    '🏘️',
    '🏗️',
    '🏛️',
    '🏰',
    '🏯',
    '🏟️',
    '💼',
    '💻',
    '📊',
    '📈',
    '📉',
    '📋',
    '📝',
    '📞',
    '💰',
    '🏆',
    '🎯',
    '🚀',
    '⭐',
    '💡',
    '🔥',
    '💎',
    '🌟',
    '✨',
    '🎉',
    '🎊',
    '❤️',
    '💙',
    '💚',
    '💛',
    '🧡',
    '💜',
    '🖤',
    '🤍',
    '🤎',
    '💕',
    '🌍',
    '🌎',
    '🌏',
    '🗺️',
    '🌐',
    '🛫',
    '🛬',
    '✈️',
    '🚗',
    '🚕',
  ];

  // Getters
  String get selectedGender => _selectedGender;
  DateTime? get selectedDate => _selectedDate;
  bool get termsAccepted => _termsAccepted;
  String get selectedPronouns => _selectedPronouns;
  bool get isProfile1Valid => _isProfile1Valid;
  bool get isProfile2Valid => _isProfile2Valid;
  bool get isLoading => _isLoading;

  // Setters
  void setSelectedGender(String gender) {
    _selectedGender = gender;
    _validateProfile1();
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    if (date != null) {
      birthdayController.text = _formatDate(date);
    }
    _validateProfile1();
    notifyListeners();
  }

  void setTermsAccepted(bool accepted) {
    _termsAccepted = accepted;
    _validateProfile1();
    notifyListeners();
  }

  void setSelectedPronouns(String pronouns) {
    _selectedPronouns = pronouns;
    _validateProfile2();
    notifyListeners();
  }

  void setSelectedEmoji(int index, String emoji) {
    selectedEmojis[index] = emoji;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Private methods
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}';
  }

  void _validateProfile1() {
    _isProfile1Valid =
        occupationController.text.isNotEmpty &&
        _selectedGender.isNotEmpty &&
        _selectedDate != null &&
        _termsAccepted;
  }

  void _validateProfile2() {
    _isProfile2Valid =
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        _selectedPronouns.isNotEmpty;
  }

  // Public methods
  void validateProfile1() {
    _validateProfile1();
    notifyListeners();
  }

  void validateProfile2() {
    _validateProfile2();
    notifyListeners();
  }

  Future<bool> saveProfile1() async {
    if (!_isProfile1Valid) return false;

    setLoading(true);
    try {
      await Supabase.instance.client
          .from('profiles')
          .update({
            'occupation': occupationController.text,
            'gender': _selectedGender,
            'birthday': _selectedDate?.toIso8601String(),
          })
          .eq('id', Supabase.instance.client.auth.currentUser!.id);

      setLoading(false);
      return true;
    } catch (error) {
      debugPrint("Error saving profile 1: $error");
      setLoading(false);
      return false;
    }
  }

  Future<bool> saveProfile2() async {
    if (!_isProfile2Valid) return false;

    setLoading(true);
    try {
      await Supabase.instance.client
          .from('profiles')
          .update({
            'first_name': firstNameController.text,
            'last_name': lastNameController.text,
            'pronouns': _selectedPronouns,
            'bio': bioController.text,
          })
          .eq('id', Supabase.instance.client.auth.currentUser!.id);

      setLoading(false);
      return true;
    } catch (error) {
      debugPrint("Error saving profile 2: $error");
      setLoading(false);
      return false;
    }
  }

  // Get formatted bio with cities and emojis
  String getFormattedBio() {
    List<String> bioParts = [];

    for (int i = 0; i < cityControllers.length; i++) {
      if (cityControllers[i].text.isNotEmpty) {
        bioParts.add('${selectedEmojis[i]} ${cityControllers[i].text}');
      }
    }

    if (bioController.text.isNotEmpty) {
      bioParts.add(bioController.text);
    }

    return bioParts.join(' • ');
  }

  // Get profile summary for demo screen
  Map<String, dynamic> getProfileSummary() {
    return {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'pronouns': _selectedPronouns,
      'occupation': occupationController.text,
      'gender': _selectedGender,
      'birthday': birthdayController.text,
      'bio': getFormattedBio(),
      'cities': cityControllers.map((controller) => controller.text).toList(),
      'emojis': selectedEmojis,
    };
  }

  // Clear all data
  void clearData() {
    occupationController.clear();
    birthdayController.clear();
    firstNameController.clear();
    lastNameController.clear();
    bioController.clear();

    for (var controller in cityControllers) {
      controller.clear();
    }

    _selectedGender = '';
    _selectedDate = null;
    _termsAccepted = false;
    _selectedPronouns = '';
    selectedEmojis.setAll(0, ['🏠', '📊', '💼']);
    _isProfile1Valid = false;
    _isProfile2Valid = false;
    _isLoading = false;

    notifyListeners();
  }

  @override
  void dispose() {
    occupationController.dispose();
    birthdayController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();

    for (var controller in cityControllers) {
      controller.dispose();
    }

    super.dispose();
  }
}
