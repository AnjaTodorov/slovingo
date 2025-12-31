import 'package:slovingo/models/lesson_task.dart';
import 'package:slovingo/services/database_helper.dart';

class LessonTaskService {
  Future<List<LessonTask>> getTasksByLevel(String levelId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('lesson_tasks', where: 'levelId = ?', whereArgs: [levelId]);
    return rows.map(LessonTask.fromJson).toList();
  }
}
