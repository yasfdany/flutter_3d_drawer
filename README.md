[![pub package](https://img.shields.io/badge/pub-v0.0.1-blue)](https://github.com/yasfdany/flutter_3d_drawer)

a Simple 3d Drawer from [video](https://www.youtube.com/watch?v=FCyoHclCqc8&t=1157s) from Flutter Europe

## Features

- Custom Drawer Widget
- Custom Child Widget
- Fluid 3d animation

## Demo Video

<p float="left">
  <img src="https://raw.githubusercontent.com/yasfdany/flutter_3d_drawer/master/doc/gif/demo.gif" width="200px">
</p>

## Getting started

Add package to `pubspec.yaml`

```yaml
dependencies:
    flutter_3d_drawer: 0.0.1
```

## How to use

Create controller for control the drawer

```dart
DrawerControl drawerControl = DrawerControl();
```

Control the drawer

```dart
//Open drawer from controller
drawerControl.open();

//Close drawer from controller
drawerControl.close();

//Toggle drawer from controller
drawerControl.toggle();
```

Minimal usage

```dart
Flutter3dDrawer(
  controller: drawerControl,
  maxSlide: MediaQuery.of(context).size.width * 0.5,
  body: MyHome(),
  drawer: MyDrawer(),
);
```