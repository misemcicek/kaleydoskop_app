class Dream {
  final String title;
  final String details;
  final String dateTime;

  Dream({
    required this.title,
    required this.details,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'details': details,
      'date_time': dateTime,
    };
  }

  factory Dream.fromMap(Map<String, dynamic> map) {
    return Dream(
      title: map['title'],
      details: map['details'],
      dateTime: map['date_time'],
    );
  }
}