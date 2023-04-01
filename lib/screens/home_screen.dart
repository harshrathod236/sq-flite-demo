import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_flite_demo/controllers/home_controller.dart';
import 'package:sq_flite_demo/main.dart';
import 'package:sq_flite_demo/models/notes_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notes"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: homeController.notesList,
                      builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                                onDismissed: (DismissDirection direction) async {
                                  dbHelper!.delete(snapshot.data?[index].id ?? 0);
                                  homeController.notesList = dbHelper!.getNotesList();
                                  snapshot.data!.remove(snapshot.data?[index]);
                                  homeController.update();
                                },
                                key: ValueKey<int>(snapshot.data?[index].id ?? 0),
                                child: Card(
                                  child: ListTile(
                                    title: Text(snapshot.data?[index].title ?? ""),
                                    subtitle: Text(snapshot.data?[index].description ?? ""),
                                    trailing: Text("${snapshot.data?[index].age ?? ""}"),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                homeController.insertDatabase();
              },
            ),
          );
        });
  }
}
