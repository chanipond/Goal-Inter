// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class PrefBooking {
  final String id_booking;
  final String id;
  final String firstname;
  final String lastname;
  final String date;
  final String time;
  final String typeField;
  final String slip;

  PrefBooking({
    required this.id_booking,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.date,
    required this.time,
    required this.typeField, 
    required this.slip,

  });

  PrefBooking copyWith({
    String? id_booking,
    String? id,
    String? firstname,
    String? lastname,
    String? date,
    String? time,
    String? typeField,
    String? slip,
  }) {
    return PrefBooking(
      id_booking: id_booking ?? this.id_booking,
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      date: date ?? this.date,
      time: time ?? this.time,
      typeField: typeField ?? this.typeField,
      slip: slip ?? this.slip,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_booking': id_booking,
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'date': date,
      'timeStart': time,
      'typeField': typeField,
      'slip': slip,
    };
  }

  factory PrefBooking.fromMap(Map<String, dynamic> map) {
    return PrefBooking(
      id_booking: map['id_booking'],
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      date: map['date'],
      time: map['time'],
      typeField: map['typeField'],
      slip: map['slip'],
      // id_booking: json['id_booking'],
      // id: json['id'],
      // firstname: json['firstname'],
      // lastname: json['lastname'],
      // date: json['date'],
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
    return 'PrefBooking(id_booking: $id_booking, id: $id, firstname: $firstname, lastname: $lastname, date: $date, time: $time, typeField: $typeField, slip: $slip)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrefBooking &&
        other.id_booking == id_booking &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.date == date &&
        other.time == time &&
        other.typeField == typeField &&
        other.slip == slip;
  }

  @override
  int get hashCode {
    return 
        id_booking.hashCode ^
        id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        date.hashCode ^
        time.hashCode ^
        typeField.hashCode ^
        slip.hashCode;
  }
}