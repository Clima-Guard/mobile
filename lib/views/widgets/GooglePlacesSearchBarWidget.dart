
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';

class GooglePlacesSearchBarWidget extends StatefulWidget {
  final void Function(String) onPlaceSelected;
  final String initialValue;

  const GooglePlacesSearchBarWidget({
    super.key,
    required this.onPlaceSelected,
    this.initialValue = '',
  });

  @override
  _GooglePlacesSearchBarWidgetState createState() =>
      _GooglePlacesSearchBarWidgetState();
}

class _GooglePlacesSearchBarWidgetState
    extends State<GooglePlacesSearchBarWidget> {
  late TextEditingController _controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: _controller,
      focusNode: _focusNode,
      googleAPIKey: dotenv.env['GOOGLE_MAPS_API_KEY']!,
      inputDecoration: InputDecoration(
        hintText: 'Search location...',
        prefixIcon: const Icon(Icons.location_on_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      placeType: PlaceType.geocode,
      debounceTime: 300,
      itemClick: (p) {
        if (p.description != null) {
          widget.onPlaceSelected(p.description!);
          setState(() {
            _controller.text = p.description!;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
        }
        _focusNode.unfocus();
      },
    );
  }
}
