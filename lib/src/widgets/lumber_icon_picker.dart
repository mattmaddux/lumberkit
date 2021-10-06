import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lumberkit/lumberkit.dart';
import 'package:lumberkit/src/widgets/lumber_icon_button.dart';
import 'package:lumberkit/src/widgets/lumber_icon_list.dart';

class LumberIconPicker extends StatefulWidget {
  final LumberIconData? initialValue;
  final Color primaryColor;
  final Color? secondaryColor;
  final Color backgroundColor;
  final Color highlightPrimaryColor;
  final Color? highlightSecondaryColor;
  final Color highlightBackgroundColor;
  final double size;
  final double? borderRadius;
  final Color? popUpBackgroundColor;
  final Color? popUpBackgroundHighlightColor;
  final Color? popUpPrimaryColor;
  final Color? popUpPrimaryHighlightColor;
  final Color? popUpSecondaryColor;
  final Color? popUpSecondaryHighlightColor;
  final double? popUpHeight;
  final double? popUpWidth;
  final LumberPopOrientation orientation;
  final Function(LumberIconData) onSelect;

  const LumberIconPicker({
    Key? key,
    this.initialValue,
    required this.primaryColor,
    this.secondaryColor,
    required this.backgroundColor,
    required this.highlightPrimaryColor,
    this.highlightSecondaryColor,
    required this.highlightBackgroundColor,
    required this.size,
    this.borderRadius,
    this.popUpBackgroundColor,
    this.popUpBackgroundHighlightColor,
    this.popUpPrimaryColor,
    this.popUpPrimaryHighlightColor,
    this.popUpSecondaryColor,
    this.popUpSecondaryHighlightColor,
    this.popUpHeight,
    this.popUpWidth,
    this.orientation = LumberPopOrientation.bottom,
    required this.onSelect,
  }) : super(key: key);

  @override
  _LumberIconPickerState createState() => _LumberIconPickerState(
      icon: initialValue ??
          LumberIconData.fromIconData(
            FontAwesomeIcons.duotoneQuestionCircle,
          ));
}

class _LumberIconPickerState extends State<LumberIconPicker> {
  LumberIconData _icon;

  _LumberIconPickerState({required LumberIconData icon}) : _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      child: LumberPopButton(
        childBuilder: (context, open, close) => LumberIconButton(
          data: _icon,
          iconSize: widget.size * 0.6,
          buttonSize: widget.size,
          color: widget.primaryColor,
          secondaryColor: widget.secondaryColor,
          backgroundColor: widget.backgroundColor,
          hoverColor: widget.highlightPrimaryColor,
          hoverSecondaryColor: widget.highlightSecondaryColor,
          hoverBackgroundColor: widget.highlightBackgroundColor,
          borderRadius: widget.borderRadius,
          onPressed: open,
        ),
        popUpBuilder: (context, close) => _IconPickerPopUp(
          primaryColor: widget.popUpPrimaryColor ?? widget.primaryColor,
          highlightPrimaryColor:
              widget.popUpPrimaryHighlightColor ?? widget.highlightPrimaryColor,
          secondaryColor: widget.popUpSecondaryColor ?? widget.secondaryColor,
          highlightSecondaryColor: widget.popUpSecondaryHighlightColor ??
              widget.highlightSecondaryColor,
          highlightBackgroundColor: widget.popUpBackgroundHighlightColor ??
              widget.highlightBackgroundColor,
          onSelect: (newIcon) {
            setState(() {
              _icon = newIcon;
            });
            close();
            widget.onSelect(newIcon);
          },
        ),
        popUpWidth: widget.popUpWidth ?? 300,
        popUpHeight: 300,
        borderRadius: 10,
        popUpColor: widget.popUpBackgroundColor ?? widget.backgroundColor,
        orientation: widget.orientation,
      ),
    );
  }
}

class _IconPickerPopUp extends StatefulWidget {
  final Color primaryColor;
  final Color? secondaryColor;
  final Color highlightPrimaryColor;
  final Color? highlightSecondaryColor;
  final Color highlightBackgroundColor;
  final Function(LumberIconData) onSelect;

  const _IconPickerPopUp({
    Key? key,
    required this.primaryColor,
    this.secondaryColor,
    required this.highlightPrimaryColor,
    this.highlightSecondaryColor,
    required this.highlightBackgroundColor,
    required this.onSelect,
  }) : super(key: key);

  @override
  __IconPickerPopUpState createState() => __IconPickerPopUpState();
}

class __IconPickerPopUpState extends State<_IconPickerPopUp> {
  String searchQuery;
  TextEditingController textController;

  __IconPickerPopUpState()
      : searchQuery = '',
        textController = TextEditingController(text: '');

  Widget searchBar(BuildContext context) => Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black.withAlpha(100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  onChanged: (query) => searchQuery = query,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    color: widget.primaryColor,
                    fontSize: 15,
                  ),
                  cursorColor: widget.highlightPrimaryColor,
                  decoration: InputDecoration(
                    hintText: 'Icon Search',
                    hintStyle: TextStyle(color: Colors.white.withAlpha(50)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              LumberIconButton(
                data: LumberIconData.fromIconData(
                    FontAwesomeIcons.solidTimesCircle),
                iconSize: 15,
                buttonSize: 15,
                color: Colors.white.withAlpha(50),
                hoverColor: Colors.white.withAlpha(100),
                onPressed: () => {
                  setState(
                    () {
                      searchQuery = '';
                      textController.text = '';
                    },
                  ),
                },
              ),
            ],
          ),
        ),
      );

  Widget iconGrid(BuildContext context) {
    if (searchQuery.length < 3) return SizedBox.shrink();
    List<String> iconKeys = LumberIconList.keys
        .where((key) => key.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
          ),
          itemCount: iconKeys.length,
          itemBuilder: (context, index) => LumberIconButton(
            data: LumberIconData.fromIconData(LumberIconList[iconKeys[index]]!),
            borderRadius: 8,
            color: widget.primaryColor,
            secondaryColor: widget.secondaryColor,
            hoverColor: widget.highlightPrimaryColor,
            hoverSecondaryColor: widget.highlightSecondaryColor,
            hoverBackgroundColor: widget.highlightBackgroundColor,
            onPressed: () => widget.onSelect(
              LumberIconData.fromIconData(LumberIconList[iconKeys[index]]!),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          searchBar(context),
          iconGrid(context),
        ],
      ),
    );
  }
}
