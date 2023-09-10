import 'package:bloc_todo/screens/home_screen.dart';
import 'package:bloc_todo/screens/recycle_bin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/bloc_exports.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Drawer(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Tasks Drawer',
                    style: Theme.of(context).textTheme.headlineSmall!,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.task,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  title: const Text('My Tasks'),
                  trailing: Text(
                      '${state.completedTasks.length} | ${state.pendingTasks.length}'),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, HomeScreen.id),
                ),
                Divider(
                  endIndent: 0,
                  indent: 0,
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                ListTile(
                  leading: Icon(
                    Icons.recycling,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  splashColor: Theme.of(context).primaryColor,
                  title: const Text('Bin'),
                  trailing: Text(state.removedTasks.length.toString()),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, RecycleBin.id),
                ),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return Switch(
                        value: state.darkModeOn,
                        onChanged: (v) {
                          if (v) {
                            context.read<ThemeBloc>().add(DarkModeOnEvent());
                          } else {
                            context.read<ThemeBloc>().add(DarkModeOffEvent());
                          }
                        });
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
