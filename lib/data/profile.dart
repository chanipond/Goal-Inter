import 'dart:convert';

class PrefProfile {
  final String id;
  final String firstname;
  final String lastname;
  final String telephonenumber;
  final String email;
  final String password;
  final String userlevel;

  PrefProfile({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.telephonenumber,
    required this.email,
    required this.password,
    required this.userlevel,
  });

  PrefProfile copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? telephonenumber,
    String? email,
    String? password,
    String? userlevel,
  }) {
    return PrefProfile(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      telephonenumber: telephonenumber ?? this.telephonenumber,
      email: email ?? this.email,
      password: password ?? this.password,
      userlevel: userlevel ?? this.userlevel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'telephonenumber': telephonenumber,
      'email': email,
      'password': password,
      'userlevel': userlevel,
    };
  }

  factory PrefProfile.fromMap(Map<String, dynamic> map) {
    return PrefProfile(
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      telephonenumber: map['telephonenumber'],
      email: map['email'],
      password: map['password'],
      userlevel: map['userlevel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrefProfile.fromJson(String source) =>
      PrefProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrefProfile(id: $id, firstname: $firstname, lastname: $lastname,  telephonenumber: $telephonenumber, email: $email, password: $password, userlevel: $userlevel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrefProfile &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.telephonenumber == telephonenumber &&
        other.email == email &&
        other.password == password &&
        other.userlevel == userlevel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        telephonenumber.hashCode ^
        email.hashCode ^
        password.hashCode;
  }
}

