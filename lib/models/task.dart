/// A single to-do item managed by TaskFlow.
///
/// Kept deliberately tiny -- this project is a git/GitHub practice ground,
/// not an app design exercise. Resist the urge to over-engineer this class;
/// most of the "interesting" work in this repo happens in the commit
/// history, not here.
class Task {
  Task({
    required this.id,
    required this.title,
    this.done = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final int id;
  final String title;
  final bool done;
  final DateTime createdAt;

  Task copyWith({String? title, bool? done}) {
    return Task(
      id: id,
      title: title ?? this.title,
      done: done ?? this.done,
      createdAt: createdAt,
    );
  }

  @override
  String toString() {
    final mark = done ? 'x' : ' ';
    return '[$mark] #$id $title';
  }
}
