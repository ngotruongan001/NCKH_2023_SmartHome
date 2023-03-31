class ResponseUser {
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final String? name;
  final String? phoneNumber;
  // final String? position;
  final String? departmentName;
  final String? departmentCode;
  final String? typeUser;

  ResponseUser({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.name,
    this.phoneNumber,
    // this.position,
    this.departmentName,
    this.departmentCode,
    this.typeUser,
  });

  factory ResponseUser.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseUser(
      accessToken: parsedJson['accessToken'] as String,
      refreshToken: parsedJson['refreshToken'] as String,
      tokenType: parsedJson['tokenType'] as String,
      name: parsedJson['name'] as String,
      phoneNumber: parsedJson['phoneNumber'] as String,
      // position: parsedJson['position'] as String,
      departmentName: parsedJson['departmentName'] as String,
      departmentCode: parsedJson['departmentCode'] as String,
      typeUser: parsedJson['typeUser'] as String,
    );
  }
  @override
  String toString() {
    return "{accessToken: $accessToken - refreshToken: $refreshToken - tokenType: $tokenType - name: $name - phoneNumber: $phoneNumber - post_date: $departmentName - departmentCode: $departmentCode}";
  }
}
