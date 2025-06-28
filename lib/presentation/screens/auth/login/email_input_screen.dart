import 'package:auth_test/logic/auth/auth_provider.dart';
import 'package:auth_test/presentation/theme/default_colors.dart';
import 'package:auth_test/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({Key? key}) : super(key: key);

  @override
  State<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });
    final email = _emailController.text.trim();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final result = await provider.sendCode(email);
    setState(() {
      _isLoading = false;
      _errorText = result;
    });
    if (result == null) {
      Navigator.pushNamed(context, '/code_input', arguments: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Welcome back,', style: theme.textTheme.bodyMedium),
                        Text('Rohit thakur', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const Icon(Icons.person_outline, size: 32),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 180,
                  child: Image.network(
                    'https://cdni.iconscout.com/illustration/premium/thumb/couple-worried-about-money-security-illustration-download-in-svg-png-gif-file-formats--saving-safe-sheldy-pack-people-illustrations-4873738.png?f=webp',
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 120, color: DefaultColors.secondary),
                  ),
                ),
                const SizedBox(height: 24),
                Text('ENTER YOUR EMAIL', style: theme.textTheme.titleMedium?.copyWith(color: DefaultColors.primary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter email',
                          errorText: _errorText,
                          filled: true,
                          fillColor: DefaultColors.secondary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        ),
                        validator: (value) => validateEmail(value),
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DefaultColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    _sendCode();
                                  }
                                },
                          child: _isLoading
                              ? const CircularProgressIndicator(color: DefaultColors.primaryBackground)
                              : const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or login with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png',
                      height: 24,
                    ),
                    label: const Text('Google', style: TextStyle(fontWeight: FontWeight.bold,color: DefaultColors.primaryTextColor)),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: DefaultColors.secondary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: DefaultColors.primaryBackground,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {},
                      child: Text('Sign up', style: TextStyle(color: DefaultColors.primaryTextColor, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 