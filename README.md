Simple 3d Drawer from a [video](https://www.youtube.com/watch?v=FCyoHclCqc8&t=1157s) from Flutter Europe

## Features

- Custom Drawer Widget
- Custom Child Widget
- Fluid 3d animation

## Demo Video

<p float="left">
  <img src="https://raw.githubusercontent.com/yasfdany/analog_clock_picker/master/doc/gif/demo.gif" width="200px">
</p>

## Getting started

Add package to `pubspec.yaml`

```yaml
dependencies:
    analog_clock_picker: 0.0.6
```

## How to use

Create controller for control the value of the clock

```dart
AnalogClockController analogClockController = AnalogClockController();
```

You can provide default value inside the controller

```dart
AnalogClockController analogClockController = AnalogClockController(
  value: DateTime.now(),
  periodType: PeriodType.am,
  onPeriodTypeChange: (date, period) {
    //TODO : Do Something
  },
);
```

you can set period change listener after initialize it

```dart
analogClockController.setOnPeriodTypeChangeListener((date, period) {
      //TODO : Do Something
});
```

Minimal usage

```dart
AnalogClockPicker(
  controller: analogClockController,
  size: MediaQuery.of(context).size.width * 0.74,
  secondHandleColor: Colors.red,
  minutesHandleColor: Colors.black,
  hourHandleColor: Colors.black,
  clockBackground: Image.asset(
    AssetImages.clockBackground,
  ),
  onClockChange: (date){
    //TODO : Do Something
  },
)
```