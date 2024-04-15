import 'package:actividad_7/controllers/UserController.dart';
import 'package:actividad_7/models/User.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    _userController.getUser();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Usuarios'),
        ),
        body: FutureBuilder(
          future: _userController.getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  List<User> users = snapshot.data ?? [];
                  return createList(users);
                } else {
                  return const Text("Error al consumir la api.");
                }
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                return const Text("Error al cargar. Intente de nuevo");
            }
          },
        ));
  }
}

ListView createList(List<User> users) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(users[index].name),
        subtitle: Text(users[index].email),
      );
    },
    itemCount: users.length,
  );
}
