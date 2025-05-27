import 'package:caching_package/caching_package.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const CachingExampleApp());
}

class CachingExampleApp extends StatelessWidget {
  const CachingExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caching Package Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
      home: const CachingHomePage(),
    );
  }
}

class CachingHomePage extends StatefulWidget {
  const CachingHomePage({super.key});

  @override
  State<CachingHomePage> createState() => _CachingHomePageState();
}

class _CachingHomePageState extends State<CachingHomePage> {
  final _controller = TextEditingController();
  String? _cachedValue;

  @override
  void initState() {
    super.initState();
    _loadCache();
  }

  Future<void> _saveCache() async {
    final value = _controller.text;
    if (value.isNotEmpty) {
      await CacheManager.set("greeting", value, expireAfter: const Duration(minutes: 5));
      _loadCache();
    }
  }

  Future<void> _loadCache() async {
    final value = await CacheManager.get<String>("greeting");
    setState(() {
      _cachedValue = value;
    });
  }

  Future<void> _clearCache() async {
    await CacheManager.remove("greeting");
    _loadCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caching Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter greeting'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save to Cache"),
              onPressed: _saveCache,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
            ),
            const SizedBox(height: 20),
            if (_cachedValue != null)
              Card(
                color: Colors.deepPurple.shade100,
                elevation: 4,
                child: ListTile(
                  title: Text("Cached Value", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_cachedValue!, style: TextStyle(fontSize: 16)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: _clearCache,
                  ),
                ),
              )
            else
              const Text("No cached data found"),
          ],
        ),
      ),
    );
  }
}
