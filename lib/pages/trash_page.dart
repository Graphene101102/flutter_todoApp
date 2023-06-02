import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todoapp_03/models/todo_model.dart';
import 'package:flutter_todoapp_03/pages/complete_page.dart';
import 'package:flutter_todoapp_03/pages/home_page.dart';
import 'package:flutter_todoapp_03/pages/login_page.dart';

import '../resources/app_color.dart';
import '../components/search_box.dart';
import '../components/td_appbar.dart';
import '../components/todo_item.dart';
import '../services/local/shared_prefs.dart';

// ignore: camel_case_types
class trashPage extends StatefulWidget {
  final String title;

  const trashPage({
    super.key,
    required this.title,
  });

  @override
  State<trashPage> createState() => _trashPage();
}

// ignore: camel_case_types
class _trashPage extends State<trashPage> {
  final _searchController = TextEditingController();

  int _selectedIndex = 0;

  void navi(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(
                title: 'Todos',
              )));
    }
    if (index == 1) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const completePage(
                title: 'Complete',
              )));
    }
    if (index == 2) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const trashPage(
                title: 'Trash',
              )));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      navi(index);
    });
  }

  final SharePrefs _prefs = SharePrefs();
  List<TodoModel> _todos = [];
  List<TodoModel> _searches = [];

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  _searchTodos(String searchText) {
    searchText = searchText.toLowerCase();
    _searches = _todos
        .where((element) =>
            (element.text ?? '').toLowerCase().contains(searchText) &&
            element.status == 3)
        .toList();
  }

  _getTodos() {
    _prefs.getTodos().then((value) {
      setState(() {
        if (value != null) {
          _todos = value.toList();
          _searches =
              [..._todos].where((element) => element.status == 3).toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: TdAppBar(
          rightPressed: () async {
            bool? status = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('😍'),
                content: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Do you want to logout?',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()))
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            if (status ?? false) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          },
          title: widget.title),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 12.0, bottom: 92.0),
                child: Column(
                  children: [
                    SearchBox(
                        onChanged: (value) =>
                            setState(() => _searchTodos(value)),
                        controller: _searchController),
                    const Divider(
                        height: 32.6, thickness: 1.36, color: AppColor.grey),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _searches.length,
                      itemBuilder: (context, index) {
                        TodoModel todo = _searches.reversed.toList()[index];
                        return TodoItem(
                          onTap: () {},
                          onDeleted: () async {
                            bool? status = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('😍'),
                                content: const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Do you want to remove the todo?',
                                        style: TextStyle(fontSize: 22.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          Navigator.pop(context, true);
                                        },
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                            if (status ?? false) {
                              setState(() {
                                _todos.remove(todo);
                                //_searches.remove(todo);
                                _prefs.addTodos(_todos);
                                _getTodos();
                              });
                            }
                          },
                          restore: () {
                            setState(() {
                              todo.status = 1;
                              _prefs.addTodos(_todos);
                              _getTodos();
                            });
                          },
                          text: todo.text ?? '-:-',
                          status: todo.status ?? 0,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16.8),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.blue),
          label: 'Home',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.check,
            color: Colors.blue,
          ),
          label: 'Complete',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delete, color: Colors.blue),
          label: 'Trash',
          backgroundColor: Colors.pink,
        ),
      ], currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}
