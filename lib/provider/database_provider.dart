import 'package:flutter/foundation.dart';
import '../data/database/database_helper.dart';
import '../data/model/task_model.dart';

class DbProvider extends ChangeNotifier {
  List<Task> _task = [];
  List<Task> _taskDone = [];
  List<Task> _allTask = [];
  List<Task> _searchResult = [];
  String _searchQuery = "";
  late DatabaseHelper _dbHelper;

  String get searchQuery => _searchQuery;

  List<Task> get task => _task;

  List<Task> get taskDone => _taskDone;

  List<Task> get allTask => _allTask;

  List<Task> get searchResult => _searchResult;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllTask();
  }

  void _getAllTask() async {
    _allTask = await _dbHelper.getTask();
    _task = _allTask.where((task) => task.isDone == 0).toList();
    _taskDone = _allTask.where((task) => task.isDone == 1).toList();
    if (_searchResult.isNotEmpty) {
      search(_searchQuery);
    }
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    _getAllTask();
  }

  Future<Task> getTaskById(int id) async {
    return await _dbHelper.getTaskById(id);
  }

  void updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    _getAllTask();
  }

  void deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    _getAllTask();
  }

  void toggleTaskDoneStatus(taskId) async {
    Task taskToUpdate = await _dbHelper.getTaskById(taskId);
    taskToUpdate.isDone = taskToUpdate.isDone == 0 ? 1 : 0;
    await _dbHelper.updateTask(taskToUpdate);
    _getAllTask();
  }

  void search(query) {
    _searchResult.clear();
    _searchResult = _allTask
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void updateSearchQuery(query) {
    _searchQuery = query;
    notifyListeners();
  }

  searchResultClear() {
    searchResult.clear();
    notifyListeners();
  }
}
