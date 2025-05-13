
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';

class GooglePlacesSearchBarWidget extends StatefulWidget {
  @override
  _GooglePlacesSearchBarWidgetState createState() =>
      _GooglePlacesSearchBarWidgetState();
}

class _GooglePlacesSearchBarWidgetState
    extends State<GooglePlacesSearchBarWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

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
        hintText: 'Search for a place',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      placeType: PlaceType.geocode,
      debounceTime: 300,
      itemClick: (Prediction p) {
        setState(() {
          _controller.text = p.description!;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        });
        _focusNode.unfocus();
      },
    );
  }
}
