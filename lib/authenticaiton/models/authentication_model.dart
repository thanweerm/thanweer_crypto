import 'dart:convert';

class AuthenticationModel {
  final bool? isValid;

  final String? name;

  AuthenticationModel({
    required this.isValid,
    this.name,
  });

  AuthenticationModel copyWith({
    bool? isValid,
    String? name,
  }) {
    return AuthenticationModel(
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isValid': isValid,
      'name': name,
    };
  }

  factory AuthenticationModel.fromMap(Map<String, dynamic>? map) {
    return AuthenticationModel(
      isValid: map?['isValid'],
      name: map?['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationModel.fromJson(String source) =>
      AuthenticationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthenticationModel(isValid: $isValid, '
        ' name: $name'
        ')';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AuthenticationModel && o.isValid == isValid && o.name == name;
  }

  @override
  int get hashCode {
    return isValid.hashCode ^ name.hashCode;
  }
}
