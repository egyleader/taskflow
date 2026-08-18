import 'package:taskflow/repository/task_repository.dart';
import 'package:test/test.dart';

void main() {
  group('TaskRepository', () {
    test('starts empty', () {
      final repo = TaskRepository();
      expect(repo.all, isEmpty);
    });

    test('addTask stores a task and assigns an incrementing id', () {
      final repo = TaskRepository();
      final first = repo.addTask('Write CURRICULUM.md');
      final second = repo.addTask('Set up branch protection');

      expect(repo.all, hasLength(2));
      expect(first.id, 1);
      expect(second.id, 2);
      expect(first.done, isFalse);
    });
  });
}
