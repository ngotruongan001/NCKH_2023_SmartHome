import 'dart:io';

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  // Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
  static final RegExp _PassRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp _phoneRegExp = RegExp(
    r'(03|07|08|09|01[2|6|8|9])+([0-9]{8})\b',
  );

  static final RegExp _fullNameRegExp = RegExp(r'^[a-zA-Z\u00C0-\u1EF9\s]+$');

  static RegExp regExpDigitOnly = RegExp('[0-9]');

  static bool stringNotNullOrEmpty(String? value) {

    if (value == null) {
      return false;
    } else if (value.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String? value) {
    if (value == null) {
      return false;
    } else if (value.trim().isEmpty) {
      return false;
    } else {
      return _emailRegExp.hasMatch(value);
    }
  }

  static bool isValidPass(String? value) {
    if (value == null) {
      return false;
    } else if (value.trim().isEmpty) {
      return false;
    } else {
      return _PassRegExp.hasMatch(value);
    }
  }

  static String? validateNotNullOrEmpty(String? value, String errorMessage) {
    if (!stringNotNullOrEmpty(value)) {
      return errorMessage;
    }
    return null;
  }

  static String? validateLength(String? value, int min, String errorMessage) {
    if (!stringNotNullOrEmpty(value)) {
      return errorMessage;
    }
    if (value!.length < min) {
      return errorMessage;
    }

    return null;
  }

  static String? validateEmail(String? value, String errorMessage) {
    if (value == null || value!.isEmpty) {
      return errorMessage;
    }

    var isValidEmail = _emailRegExp.hasMatch(value);

    if (isValidEmail) {
      return null;
    } else {
      return errorMessage;
    }
  }

  static String? validatePhoneNumber(String? value, String errorMessage) {
    if (value == null) {
      return errorMessage;
    }
    var isValidPhone = _phoneRegExp.hasMatch(value);
    if (isValidPhone) {
      return null;
    }

    return errorMessage;
  }

  static String? validNumberOrEmpty(String value, String errorMessage) {
    try {
      if (value.isEmpty) return errorMessage;
      var doubleValue = double.tryParse(value.replaceAll(',', '')) ?? 0.0;
      if (doubleValue > 0) {
        return null;
      } else {
        return errorMessage;
      }
    } catch (_) {
      return errorMessage;
    }
  }

  static bool isAllowImageSize(String imagePath) {
    try {
      var f = File(imagePath);
      var sizeInBytes = f.lengthSync();
      var sizeInMb = sizeInBytes / 1000000;
      if (sizeInMb > 5) {
        return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static String? validateFullName(String? value, String errorMessage) {
    if (!stringNotNullOrEmpty(value)) {
      return errorMessage;
    }
    if(_fullNameRegExp.hasMatch(value ?? '')){
      return null;
    }
    return errorMessage;
  }

}
