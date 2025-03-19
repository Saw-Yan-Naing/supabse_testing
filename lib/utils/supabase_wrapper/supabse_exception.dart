class SupabseException {
  final String message;
  final String code;

  SupabseException({required this.message, required this.code});

  factory SupabseException.fromMap(Map<String, dynamic> map) {
    return SupabseException(
      message: map['message'],
      code: map['code'],
    );
  }

  @override
  String toString() {
    return 'SupabseException{message: $message, code: $code}';
  }
}