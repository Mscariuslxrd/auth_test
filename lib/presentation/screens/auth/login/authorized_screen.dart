import 'package:auth_test/logic/auth/auth_provider.dart';
import 'package:auth_test/presentation/theme/default_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorizedScreen extends StatefulWidget {
  const AuthorizedScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizedScreen> createState() => _AuthorizedScreenState();
}

class _AuthorizedScreenState extends State<AuthorizedScreen> {
  String? _userId;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final result = await provider.getUserId();
    setState(() {
      _userId = result['user_id'];
      _error = result['error'];
      _loading = false;
    });
  }

  void _logout() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    await provider.logout();
    Navigator.pushNamedAndRemoveUntil(context, '/email_input', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
                ? Text(_error!, style: const TextStyle(color: DefaultColors.primary))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You are logged in!'),
                      const SizedBox(height: 16),
                      Text('User ID: $_userId'),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _logout,
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
      ),
    );
  }
} 