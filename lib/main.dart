import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IC Scouting Login',
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: const Color.fromARGB(255, 80, 80, 80),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: const Color.fromARGB(255, 80, 80, 80),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    String name = _nameController.text.trim();
    String id = _idController.text.trim();
    String password = _passwordController.text.trim();

    // Validation logic
    if ((name == 'Jared' && id == '1' && password == '1') || 
        (name == 'Anton' && id == '2' && password == '1')) {
      // Successful login, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(name: name)),
      );
    } else {
      // Invalid login attempt
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid name, ID, or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add the logo
              Image.asset(
                'assets/ICRoboticsLogo.png',
                height: 225,
                width: 225,
              ),
              const SizedBox(height: 20),
              // Name Input Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Name (Jared or Anton)', 
                  labelStyle: TextStyle(
                    color: Colors.black87,
                  ),
                  filled: false,
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ID Input Field
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'Enter ID (1 or 2)',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                  ),
                  filled: false,
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Password Input Field
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                  ),
                  filled: false,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () => _login(context),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String name;

  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Welcome $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select a page to navigate to:'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageOne()),
                );
              },
              child: const Text('Pit'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageTwo()),
                );
              },
              child: const Text('Match'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageThree()),
                );
              },
              child: const Text('Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final TextEditingController _teamController = TextEditingController();
  String? _teamNumber;
  List<bool> _selectedMechanisms = List.generate(7, (index) => false);
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pit')),
      body: Column(
        children: [
          _TeamEntryForm(controller: _teamController, onSubmit: _handleTeamSubmission),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _ImageUploadSection(onImageSelected: _handleImageSelection),
                ),
                const VerticalDivider(),
                Expanded(
                  child: _MechanismDisplaySection(
                    selectedMechanisms: _selectedMechanisms,
                    onChanged: _handleMechanismChange,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _saveData,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _handleTeamSubmission() {
    setState(() {
      _teamNumber = _teamController.text;
      if (_teamNumber!.length > 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid team number.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scouting for Team: $_teamNumber')),
        );
      }
    });
  }

  Future<void> _handleImageSelection(String imagePath) async {
    setState(() {
      _imagePath = imagePath;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Uploaded: $_imagePath')),
    );
  }

  void _handleMechanismChange(int index, bool value) {
    setState(() {
      _selectedMechanisms[index] = value;
    });
  }

  Future<void> _saveData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_teamNumber.txt'); // Save as '<_teamNumber>.txt'

    String data = 'Team Number: $_teamNumber\nMechanisms:\n';
    const mechanismNames = [
      'Can Shoot',
      'Can Climb',
      'Can Trap',
      'Can Intake',
      'Can Drive',
      'Can Pass',
      'Can Amp',
    ];

    // Record selected mechanisms
    for (int i = 0; i < mechanismNames.length; i++) {
      if (_selectedMechanisms[i]) {
        data += '- ${mechanismNames[i]}\n';
      }
    }

    // Handle image copying and path update
    String savedImagePath = '';
    if (_imagePath.isNotEmpty) {
      final imageFile = File(_imagePath);
      savedImagePath = '${directory.path}/$_teamNumber.jpg'; // Path for the saved image
      final imageCopy = File(savedImagePath);
      await imageFile.copy(imageCopy.path); // Copy image to documents directory
      data += 'Image Path: $savedImagePath\n'; // Store the saved image path in scouting data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image copied to documents.')),
      );
    }

    // Write scouting data to the file
    await file.writeAsString(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scouting data saved.')),
    );
  }
}

class _TeamEntryForm extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const _TeamEntryForm({Key? key, required this.controller, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Enter FRC Team Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            maxLength: 4,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Submit Team Number'),
          ),
        ],
      ),
    );
  }
}

class _ImageUploadSection extends StatelessWidget {
  final Function(String) onImageSelected;

  const _ImageUploadSection({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Upload Robot Pictures',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                onImageSelected(pickedFile.path);
              }
            },
            child: const Text('Select Image'),
          ),
        ],
      ),
    );
  }
}

class _MechanismDisplaySection extends StatelessWidget {
  final List<bool> selectedMechanisms;
  final Function(int, bool) onChanged;

  const _MechanismDisplaySection({Key? key, required this.selectedMechanisms, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mechanismNames = [
      'Can Shoot',
      'Can Climb',
      'Can Trap',
      'Can Intake',
      'Can Drive',
      'Can Pass',
      'Can Amp',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'FRC Mechanisms for 2024 Game: Crescendo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...List.generate(mechanismNames.length, (index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(mechanismNames[index])),
                Checkbox(
                  value: selectedMechanisms[index],
                  onChanged: (bool? value) {
                    if (value != null) {
                      onChanged(index, value);
                    }
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  // Define action lists for each game period
  final List<String> autonomousActions = [
    'Scored Speaker',
    'Scored Amp',
    'Crossed Line',
    'Failed to Score'
  ];

  final List<String> teleopActions = [
    'Scored Speaker',
    'Scored Amp',
    'Trapped',
    'Passed',
    'Intaked',
    'Failed to Score'
  ];

  final List<String> endgameActions = [
    'Climbed',
    'Parked',
    'Failed'
  ];

  final Map<String, int> actionCounts = {};
  String _teamNumber = ''; // Team number input

  @override
  void initState() {
    super.initState();
    // Initialize action counts to zero for all actions
    for (var action in autonomousActions) {
      actionCounts[action] = 0;
    }
    for (var action in teleopActions) {
      actionCounts[action] = 0;
    }
    for (var action in endgameActions) {
      actionCounts[action] = 0;
    }
  }

  void _incrementAction(String action) {
    setState(() {
      actionCounts[action] = (actionCounts[action] ?? 0) + 1;
    });
  }

  void _decrementAction(String action) {
    setState(() {
      actionCounts[action] = (actionCounts[action] ?? 0) > 0
          ? actionCounts[action]! - 1
          : 0;
    });
  }

  Future<void> _saveMatchData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${_teamNumber}_match.txt');

    String matchData = 'Team Number: $_teamNumber\nMatch Actions:\n';

    // Append autonomous action counts
    matchData += '\nAutonomous Actions:\n';
    for (var action in autonomousActions) {
      matchData += '$action: ${actionCounts[action]}\n';
    }

    // Append teleop action counts
    matchData += '\nTeleop Actions:\n';
    for (var action in teleopActions) {
      matchData += '$action: ${actionCounts[action]}\n';
    }

    // Append endgame action counts
    matchData += '\nEndgame Actions:\n';
    for (var action in endgameActions) {
      matchData += '$action: ${actionCounts[action]}\n';
    }

    // Save match data to the file
    await file.writeAsString(matchData);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Match data saved to: ${file.path}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Scouting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Team Number',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _teamNumber = value;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Autonomous Actions:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: autonomousActions.length,
                itemBuilder: (context, index) {
                  final action = autonomousActions[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(action)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _incrementAction(action),
                      ),
                      Text('${actionCounts[action]}'),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _decrementAction(action),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Teleop Actions:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: teleopActions.length,
                itemBuilder: (context, index) {
                  final action = teleopActions[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(action)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _incrementAction(action),
                      ),
                      Text('${actionCounts[action]}'),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _decrementAction(action),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Endgame Actions:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: endgameActions.length,
                itemBuilder: (context, index) {
                  final action = endgameActions[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(action)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _incrementAction(action),
                      ),
                      Text('${actionCounts[action]}'),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _decrementAction(action),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMatchData,
                child: const Text('Save Match Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data')),
      body: const Center(child: Text('Data')),
    );
  }
}