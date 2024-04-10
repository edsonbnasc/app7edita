import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login e Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyAppState()),
        ],
        child: MainScreen(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String? username;
  String? password;
  String? newEmail;
  String? newPassword;
  int currentIndex = 0;

  void login(String username, String password) {
    // Verificar se o usuário e a senha estão corretos (simulação simples)
    if (username == 'admin' && password == 'admin') {
      notifyListeners();
    }
  }

  void logout() {
    username = null;
    password = null;
    newEmail = null;
    newPassword = null;
    notifyListeners();
  }

  void cadastrar(String username, String password) {
    // Implementar lógica de cadastro de usuário aqui
  }

  void editar(String newEmail, String newPassword) {
    // Implementar lógica de edição de usuário aqui
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context, listen: false);
    final screens = [
      LoginPage(),
      EditarUsuarioPage(),
    ];
    return Scaffold(
      body: screens.elementAt(myAppState.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myAppState.currentIndex,
        onTap: (index) {
          myAppState.currentIndex = index;
          if (index == 0) {
            myAppState.username = null;
            myAppState.password = null;
            myAppState.newEmail = null;
            myAppState.newPassword = null;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Editar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sair',
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Digite seu usuário e senha:',
            ),
            TextField(
              onChanged: (value) => myAppState.username = value,
              decoration: InputDecoration(
                labelText: 'Usuário',
              ),
            ),
            TextField(
              onChanged: (value) => myAppState.password = value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                myAppState.login(myAppState.username!, myAppState.password!);
                Navigator.pop(context);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroPage()),
                );
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cadastre seu usuário e senha:',
            ),
            TextField(
              onChanged: (value) => myAppState.username = value,
              decoration: InputDecoration(
                labelText: 'Usuário',
              ),
            ),
            TextField(
              onChanged: (value) => myAppState.password = value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                myAppState.cadastrar(myAppState.username!, myAppState.password!);
                Navigator.pop(context);
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditarUsuarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Editar usuário:',
            ),
            TextField(
              onChanged: (value) => myAppState.newEmail = value,
              decoration: InputDecoration(
                labelText: 'Novo E-mail',
              ),
            ),
            TextField(
              onChanged: (value) => myAppState.newPassword = value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nova Senha',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                myAppState.editar(myAppState.newEmail!, myAppState.newPassword!);
                Navigator.pop(context);
              },
              child: Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}
