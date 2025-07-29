import 'package:flutter/material.dart';

class WorkoutCreatorScreen extends StatefulWidget {
  @override
  _WorkoutCreatorScreenState createState() => _WorkoutCreatorScreenState();
}

class _WorkoutCreatorScreenState extends State<WorkoutCreatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _warmUpController = TextEditingController();
  List<TextEditingController> _movementControllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Workout'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Workout Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _warmUpController,
                decoration: InputDecoration(labelText: 'Warm-up'),
                maxLines: 3,
              ),
              SizedBox(height: 24),
              Text("Movements", style: Theme.of(context).textTheme.titleLarge),
              ..._movementControllers.map((controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Movement'),
                  ),
                );
              }).toList(),
              SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _movementControllers.add(TextEditingController());
                  });
                },
                icon: Icon(Icons.add),
                label: Text("Add Movement"),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save workout logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Workout saved!')),
                    );
                  }
                },
                child: Text('Save Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
