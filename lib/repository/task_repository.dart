import '../models/task.dart';

/// In-memory storage for [Task]s.
///
/// Intentionally minimal at v0.1.0 -- later levels will grow this class
/// (filtering, completing, deleting) which is exactly what makes it a good
/// source of realistic merge conflicts when two branches touch it at once.
class TaskRepository {
  final List<Task> _tasks = <Task>[];
  int _nextId = 1;

  List<Task> get all => List.unmodifiable(_tasks);

  Task addTask(String title) {
    final task = Task(id: _nextId++, title: title);
    _tasks.add(task);
    return task;
  }
}
