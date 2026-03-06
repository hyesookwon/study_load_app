import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/assignment.dart';
import '../widgets/responsive_layout.dart';

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _deadline = DateTime.now().add(const Duration(days: 7));

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context,
    bool isStart,
  ) async {
    final initial = isStart ? _startDate : _deadline;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_deadline.isBefore(_startDate)) _deadline = _startDate;
        } else {
          _deadline = picked;
          if (_startDate.isAfter(_deadline)) _startDate = _deadline;
        }
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final state = AppStateScope.of(context);
    final a = Assignment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      startDate: _startDate,
      deadline: _deadline,
    );
    state.addAssignment(a);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Add assignment'),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Assignment name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty)
                              ? 'Enter a name'
                              : null,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: const Text('Start date'),
                      subtitle: Text(
                        '${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _pickDate(context, true),
                    ),
                    ListTile(
                      title: const Text('Deadline'),
                      subtitle: Text(
                        '${_deadline.year}-${_deadline.month.toString().padLeft(2, '0')}-${_deadline.day.toString().padLeft(2, '0')}',
                      ),
                      trailing: const Icon(Icons.event),
                      onTap: () => _pickDate(context, false),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: _submit,
                      child: const Text('Add assignment'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
