import 'package:flutter/material.dart';
import 'package:flutter_3d_drawer/flutter_3d_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DrawerControl drawerControl = DrawerControl();

  @override
  Widget build(BuildContext context) {
    return Flutter3dDrawer(
      controller: drawerControl,
      maxSlide: MediaQuery.of(context).size.width * 0.5,
      body: Scaffold(
        appBar: AppBar(
          title: const Text("3D Drawer"),
          leading: IconButton(
            onPressed: () {
              drawerControl.toggle();
            },
            icon: const Icon(Icons.menu_rounded),
          ),
        ),
      ),
      drawer: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
        ),
        color: Colors.white,
        child: Column(
          children: [
            ItemDrawer(
              title: "Home",
              icon: Icons.home_rounded,
              drawerControl: drawerControl,
            ),
            ItemDrawer(
              title: "History",
              icon: Icons.history_rounded,
              drawerControl: drawerControl,
            ),
            ItemDrawer(
              title: "Profile",
              icon: Icons.account_circle_rounded,
              drawerControl: drawerControl,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final String title;
  final DrawerControl drawerControl;

  const ItemDrawer({
    Key? key,
    required this.icon,
    required this.title,
    required this.drawerControl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          drawerControl.close();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
