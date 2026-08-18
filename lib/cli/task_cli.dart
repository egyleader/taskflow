import '../repository/task_repository.dart';

/// The command-line front end for TaskFlow.
///
/// v0.1.0 intentionally wires up nothing beyond a usage message. Wiring up
/// the first real command (`add`) is Level 1 of the curriculum -- see
/// CURRICULUM.md -- and is meant to be done on a feature branch through a
/// pull request, not committed straight to main.
class TaskCli {
  TaskCli({TaskRepository? repository})
      : repository = repository ?? TaskRepository();

  final TaskRepository repository;

  void run(List<String> args) {
    if (args.isEmpty) {
      _printUsage();
      return;
    }

    switch (args.first) {
      default:
        _printUsage();
    }
  }

  void _printUsage() {
    // ignore: avoid_print
    print('taskflow: no commands wired up yet. See CURRICULUM.md, Level 1.');
  }
}
