import 'dart:convert';

class PrefBooking {
  final String idinformation;
  final String id;
  final String title;
  final String content;
  final String image;

  PrefBooking({
    required this.idinformation,
    required this.id,
    required this.title,
    required this.content,
    required this.image,  
  });

  PrefBooking copyWith({
    String? idinformation,
    String? id,
    String? title,
    String? content,
    String? image,
  }) {
    return PrefBooking(
      idinformation: idinformation ?? this.idinformation,
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idinformation': idinformation,
      'id': id,
      'title': title,
      'content': content,
      'image': image,
    };
  }

  factory PrefBooking.fromMap(Map<String, dynamic> map) {
    return PrefBooking(
      idinformation: map['idinformation'],
      id: map['id'],
      title: map['title'],
      content: map['content'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrefBooking.fromJson(String source) =>
      PrefBooking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrefBooking(idinformation: $idinformation, id: $id, title: $title, content: $content,  image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrefBooking &&
        other.idinformation == idinformation &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.image == image;
  }

  @override
  int get hashCode {
    return 
        idinformation.hashCode ^
        id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        image.hashCode;
  }
}