import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedBirthPlace;
  final ValueChanged<String> onChangedage;

  const NoteFormWidget({
    super.key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedBirthPlace,
    required this.onChangedage,
    // required void Function(dynamic age) onChangedage, required String age,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: isImportant ?? false,
                    onChanged: onChangedImportant,
                  ),
                  Expanded(
                    child: Slider(
                      value: (number ?? 0).toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      onChanged: (number) => onChangedNumber(number.toInt()),
                    ),
                  )
                ],
              ),
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
              buildBirthPlace(),
              const SizedBox(height: 8),
              buildage()
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Job Title',
          hintStyle: TextStyle(color: Color.fromARGB(179, 148, 146, 146)),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Please Enter Job Title' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Description',
          hintStyle: TextStyle(color: Color.fromARGB(179, 148, 146, 146)),
        ),
        validator: (description) => description != null && description.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget buildBirthPlace() => TextFormField(
        maxLines: 1,
        initialValue:
            '', // Initial value for birth place, you can update as needed
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Category',
          hintStyle: TextStyle(
            color: Color.fromARGB(179, 148, 146, 146),
            fontWeight: FontWeight.bold,
          ),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Please Enter Category' : null,
        onChanged: onChangedBirthPlace, // Add this line for the new field
      );

  Widget buildage() => TextFormField(
        maxLines: 1,
        initialValue:
            '', // Initial value for birth place, you can update as needed
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Location',
          hintStyle: TextStyle(
            color: Color.fromARGB(179, 148, 146, 146),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Please Enter Location' : null,
        onChanged: onChangedage, // Add this line for the new field
      );
}
