import 'package:flutter/material.dart';
import 'package:chatapp/chatpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color(0xff171c21),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(),
                hintText: 'Create a username',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Builder(builder: (context) {
              return TextButton(
                onPressed: () async {
                  Map<String, Object> values = <String, Object>{'n': 'g'};
                  SharedPreferences.setMockInitialValues(values);

                  prefs = await SharedPreferences.getInstance();
                  await prefs.setString('n', _name.text);

                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => CPage()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Continue"),
              );
            }),
          ],
        ),
      ),
    ));
  }
}
