import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_repository/supabase_repository.dart';
import 'package:task_repository/task_repository.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

class SupabaseApiRepositoryMock extends Mock implements SupabaseApiRepository {}

void main() {
  final supabaseApiRepository = SupabaseApiRepositoryMock();
  final taskRepository = TaskRepository(
    supabaseApiRepository: supabaseApiRepository,
  );

  group('get list task', () {
    test('should return Exception on failure', () async {
      when(
        () => supabaseApiRepository.getTasks(),
      ).thenThrow(Exception('Failure'));

      await expectLater(
        taskRepository.getTasks(),
        throwsA(isA<GetTasksException>()),
      );
    });

    test('should return list task on success', () async {
      when(() => supabaseApiRepository.getTasks()).thenAnswer(
        (_) async => [
          TaskModel(
            id: '0',
            title: 'test',
            description: 'test',
            dueDate: 'test',
          ),
          TaskModel(
            id: '1',
            title: 'test',
            description: 'test',
            dueDate: 'test',
          ),
        ],
      );

      expect(
        await taskRepository.getTasks(),
        containsAll([
          isA<TaskModel>().having((a) => a.id, 'id', '0'),
          isA<TaskModel>().having((a) => a.id, 'id', '1'),
        ]),
      );
    });
  });

  group('create task', () {
    test('should return Exception on failure', () async {
      final mockModel = TaskModel(title: '', description: '', dueDate: '');
      when(
        () => supabaseApiRepository.createTask(mockModel),
      ).thenThrow(Exception('Failure'));

      await expectLater(
        taskRepository.createTask(mockModel),
        throwsA(isA<CreateTaskException>()),
      );
    });

    test('should return void on success', () async {
      final mockModel = TaskModel(
        title: 'test',
        description: 'test',
        dueDate: 'test',
      );
      when(
        () => supabaseApiRepository.createTask(mockModel),
      ).thenAnswer((_) async {});

      await taskRepository.createTask(mockModel);
    });
  });

  group('update task', () {
    test('should return Exception on failure', () async {
      final mockModel = TaskModel(title: '', description: '', dueDate: '');
      when(
        () => supabaseApiRepository.updateTask(mockModel),
      ).thenThrow(Exception('Failure'));

      await expectLater(
        taskRepository.updateTask(mockModel),
        throwsA(isA<UpdateTaskException>()),
      );
    });

    test('should return void on success', () async {
      final mockModel = TaskModel(
        title: 'test',
        description: 'test',
        dueDate: 'test',
      );
      when(
        () => supabaseApiRepository.updateTask(mockModel),
      ).thenAnswer((_) async {});

      await taskRepository.updateTask(mockModel);
    });
  });

  group('delete task', () {
    test('should return Exception on failure', () async {
      when(
        () => supabaseApiRepository.deleteTask(''),
      ).thenThrow(Exception('Failure'));
      await expectLater(
        taskRepository.deleteTask(''),
        throwsA(isA<DeleteTaskException>()),
      );
    });

    test('should return void on success', () async {
      when(() => supabaseApiRepository.deleteTask('')).thenAnswer((_) async {});
      await taskRepository.deleteTask('');
    });
  });
}
