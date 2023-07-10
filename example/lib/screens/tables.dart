import 'package:easy_software/tables/headers.dart';
import 'package:easy_software/tables/tables.dart';
import 'package:example/data/user_data.dart';
import 'package:example/models/user.dart';
import 'package:flutter/material.dart';

class TablesExamples extends StatefulWidget {
  const TablesExamples({super.key});

  @override
  State<TablesExamples> createState() => _TablesExamplesState();
}

class _TablesExamplesState extends State<TablesExamples> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: PaginatedTable<User>(
                data: usersTestData,
                headers: [
                  TableHeader(label: 'Nombre', flex: 2),
                  TableHeader(label: 'Apellido', flex: 2),
                  TableHeader(label: 'Email'),
                ],
                rowElementsBuilder: (User user) => [
                  Text(user.name),
                  Text(user.lastName),
                  Text(user.email.toString()),
                ],
                // showButtons: false,
                onDelete: (model) {},
                onEdit: (model) {},
                onDetails: (model) {},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ScrollableTable(
                data: usersTestData,
                headers: [
                  TableHeader(label: 'Nombre', flex: 2),
                  TableHeader(label: 'Apellido', flex: 2),
                  TableHeader(label: 'Email'),
                ],
                rowElementsBuilder: (User user) => [
                  Text(user.name),
                  Text(user.lastName),
                  Text(user.email.toString()),
                ],
                // showButtons: false,
                onDelete: (model) {},
                onEdit: (model) {},
                onDetails: (model) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
