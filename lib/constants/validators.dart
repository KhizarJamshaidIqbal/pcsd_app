String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name Field is required';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email Field is required';
  }
  return null;
}

String? validatePassword(String? value , String email) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one capital letter';
  }
  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }
    if (value == email) {
    return 'Password cannot match with email';
  }
  return null;
}

String? validateconfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Confirm Password is required';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateNotificationTitle(String? value) {
  if (value == null || value.isEmpty) {
    return 'Title Field is required';
  }
  return null;
}

String? validateNotificationbody(String? value) {
  if (value == null || value.isEmpty) {
    return 'Body Field is required';
  }
  return null;
}