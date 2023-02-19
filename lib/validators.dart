class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static String? validateEmail(String value) {
    if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.length < 5) {
      return 'Password must be at least 5 characters';
    }
    return null;
  }

  static String? required(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }


}
