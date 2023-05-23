// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class PrefBooking {
  final String id_booking;
  final String id;
  final String firstname;
  final String lastname;
  final String datetime_start;
  final String datetime_end;
  final String typeField;

  PrefBooking({
    required this.id_booking,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.datetime_start,
    required this.datetime_end,
    required this.typeField, 

  });

  PrefBooking copyWith({
    String? id_booking,
    String? id,
    String? firstname,
    String? lastname,
    String? datetime_start,
    String? datetime_end,
    String? typeField,
  }) {
    return PrefBooking(
      id_booking: id_booking ?? this.id_booking,
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      datetime_start: datetime_start ?? this.datetime_start,
      datetime_end: datetime_end ?? this.datetime_end,
      typeField: typeField ?? this.typeField,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_booking': id_booking,
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'datetime_start': datetime_start,
      'datetime_end': datetime_end,
      'typeField': typeField,
    };
  }

  factory PrefBooking.fromMap(Map<String, dynamic> map) {
    return PrefBooking(
      id_booking: map['id_booking'],
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      datetime_start: map['datetime_start'],
      datetime_end: map['datetime_end'],
      typeField: map['typeField'],
      // id_booking: json['id_booking'],
      // id: json['id'],
      // firstname: json['firstname'],
      // lastname: json['lastname'],
      // datetime_start: json['datetime_start'],
      // time: json['time'],
      // typeField: json['typeField'],
      // slip: json['slip'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrefBooking.fromJson(String source) =>
      PrefBooking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrefBooking(id_booking: $id_booking, id: $id, firstname: $firstname, lastname: $lastname, datetime_start: $datetime_start, datetime_end: $datetime_end, typeField: $typeField)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrefBooking &&
        other.id_booking == id_booking &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.datetime_start == datetime_start &&
        other.datetime_end == datetime_end &&
        other.typeField == typeField;
  }

  @override
  int get hashCode {
    return 
        id_booking.hashCode ^
        id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        datetime_start.hashCode ^
        datetime_end.hashCode ^
        typeField.hashCode;
  }
}