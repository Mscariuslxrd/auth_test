String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Введите email';
  }
  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Incorrect email';
  }
  return null;
} 