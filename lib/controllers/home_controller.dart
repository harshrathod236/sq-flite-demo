import 'package:get/get.dart';
import 'package:sq_flite_demo/db/db_helper.dart';
import 'package:sq_flite_demo/main.dart';
import 'package:sq_flite_demo/models/notes_model.dart';

class HomeController extends GetxController {
  Future<List<NotesModel>>? notesList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
  }

  void loadData() async {
    notesList = dbHelper!.getNotesList();
    update();
  }

  void insertDatabase() {
    dbHelper!
        .insert(
      NotesModel(
        title: "First Name",
        age: 21,
        description: "My Name is Harsh",
        email: "harsh@gmail.com",
      ),
    )
        .then((value) {
      print("Data added successfully");
      notesList = dbHelper!.getNotesList();
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
