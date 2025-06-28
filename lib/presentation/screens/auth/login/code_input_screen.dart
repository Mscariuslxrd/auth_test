import 'package:auth_test/logic/auth/auth_provider.dart';
import 'package:auth_test/presentation/theme/default_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodeInputScreen extends StatefulWidget {
  final String email;
  const CodeInputScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<CodeInputScreen> createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  String? _validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter the code';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'The code must contain 6 digits.';
    }
    return null;
  }

  Future<void> _confirmCode() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });
    final code = _codeController.text.trim();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final result = await provider.confirmCode(widget.email, code);
    setState(() {
      _isLoading = false;
      _errorText = result;
    });
    if (result == null) {
      Navigator.pushReplacementNamed(context, '/authorized');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor:  DefaultColors.primaryBackground,
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
                Text('ENTER YOUR CODE', style: theme.textTheme.titleMedium?.copyWith(color: DefaultColors.primary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter code',
                          errorText: _errorText,
                          filled: true,
                          fillColor: DefaultColors.secondary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        ),
                        validator: _validateCode,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Change mail?'),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                                    _confirmCode();
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
                      child: Text('Or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You Don't have an account? "),
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