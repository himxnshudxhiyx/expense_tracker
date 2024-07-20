String? validateStrongPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
    return 'Password must contain at least one digit';
  }
  if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
    return 'Password must contain at least one special character';
  }
  return null;
}
