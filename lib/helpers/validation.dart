class Validation {
  static String? validateEmail(String? value) {
    if (value!.isEmpty)
      return 'Please enter email';
    else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) return 'Please enter a valid email Address';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty)
      return 'Please enter password';
    else if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty)
      return 'Please enter name';
    else if (value.length < 2)
      return 'Name must be at least 2 characters';
    else if (value.length > 20) return 'Name limit 20 characters';
    return null;
  }

  static String? validateRePassword(String? value) {
    if (value!.isEmpty)
      return 'Please enter Re-type password';
    else if (value != password) return 'Password don\'t match';
    return null;
  }

  static String? name, email, password;
  static void saveName(String value) {
    name = value;
  }

  static void saveMail(String value) {
    email = value;
  }

  static void savePassword(String value) {
    password = value;
  }
}
