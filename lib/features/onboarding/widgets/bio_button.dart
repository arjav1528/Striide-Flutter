import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

class ExpandableBioField extends StatefulWidget {
  final TextEditingController controller;
  final bool initiallyExpanded;

  const ExpandableBioField({
    super.key,
    required this.controller,
    this.initiallyExpanded = false,
  });

  @override
  State<ExpandableBioField> createState() => _ExpandableBioFieldState();
}

class _ExpandableBioFieldState extends State<ExpandableBioField> {
  final List<TextEditingController> _cityControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<String> _selectedEmojis = ['🏠', '📊', '💼'];

  final List<String> _availableEmojis = [
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

  @override
  void dispose() {
    for (var controller in _cityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showCitySelectionPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A2A3E), Color(0xFF1F1F2E)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFffbf42),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Text(
                        "Pick the cities that have been part of your journey for work, home, or more",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                          fontFamily: AppTheme.bodyFontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // City Input Fields
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 3; i++) ...[
                              _buildCityInputField(i, setDialogState),
                              if (i < 2) const SizedBox(height: 16),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCityInputField(int index, StateSetter setDialogState) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          width: 200,
          child: TextField(
            controller: _cityControllers[index],
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppTheme.bodyFontFamily,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF2A2A3E),
              hintText: "City",
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontFamily: AppTheme.bodyFontFamily,
                fontSize: 16,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.6),
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        // Emoji Dropdown
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F2E),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            border: Border(
              left: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
            ),
          ),
          child: PopupMenuButton<String>(
            icon: Text(
              _selectedEmojis[index],
              style: const TextStyle(fontSize: 24),
            ),
            color: const Color(0xFF2A2A3E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: const Color(0xFFffbf42), width: 1),
            ),
            onSelected: (String emoji) {
              setDialogState(() {
                _selectedEmojis[index] = emoji;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  enabled: false,
                  child: SizedBox(
                    width: 240,
                    height: 160,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                      itemCount: _availableEmojis.length,
                      itemBuilder: (context, emojiIndex) {
                        return GestureDetector(
                          onTap: () {
                            setDialogState(() {
                              _selectedEmojis[index] =
                                  _availableEmojis[emojiIndex];
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  _selectedEmojis[index] ==
                                          _availableEmojis[emojiIndex]
                                      ? const Color(0xFFffbf42).withOpacity(0.3)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                _availableEmojis[emojiIndex],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }

  void _saveCityData() {
    // Combine all city data into a single string for the controller
    String combinedData = '';
    for (int i = 0; i < _cityControllers.length; i++) {
      if (_cityControllers[i].text.isNotEmpty) {
        combinedData += '${_selectedEmojis[i]} ${_cityControllers[i].text}';
        if (i < _cityControllers.length - 1) combinedData += '\n';
      }
    }
    widget.controller.text = combinedData;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;

    return GestureDetector(
      onTap: _showCitySelectionPopup,
      child: Container(
        width: 329 * widthMultiplier,
        padding: EdgeInsets.all(16 * widthMultiplier),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12 * widthMultiplier),
          border: Border.all(color: const Color(0xFFffbf42), width: 1.5),
          color: const Color(0xFF282632),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bio",
              style: TextStyle(
                fontSize: 16 * widthMultiplier,
                color: Colors.white,
                fontFamily: AppTheme.bodyFontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8 * widthMultiplier),
            Icon(
              Icons.edit,
              color: const Color(0xFFffbf42),
              size: 20 * widthMultiplier,
            ),
          ],
        ),
      ),
    );
  }
}
