import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String>? onChanged;

  final bool isExpanded;

  const Dropdown(
      {super.key, required this.items, this.onChanged, this.isExpanded = true});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.onChanged?.call(dropdownValue);
      },
      isExpanded: widget.isExpanded,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
