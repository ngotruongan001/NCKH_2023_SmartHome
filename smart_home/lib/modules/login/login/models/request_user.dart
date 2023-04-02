class RequestUser {
  final String? email;
  final String? password;


  RequestUser({
    this.password,
    this.email,

  });

  factory RequestUser.fromJson(Map<String, dynamic> parsedJson) {
    return RequestUser(
      email: parsedJson['email'] as String,
      password: parsedJson['password'] as String,
    );
  }
  @override
  String toString() {
    return "{email: $email - password: $password}";
  }
}
