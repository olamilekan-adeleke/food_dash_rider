String? formFieldValidator(String? value, String title, int length) {
  if (value == '' || value == null) {
    return '$title must not be empty!';
  } else if (value.length <= length) {
    return '$title must not be more that $length charaters!';
  }

  return null;
}
