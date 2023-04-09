String? emptyValidator(String? value) {
  return (value == null || value.isEmpty) ? 'なにか かいてね' : null;
}
