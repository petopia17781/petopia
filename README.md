# Petopia
### Environment

Flutter v2.0.4

Firebase

### Run Code

1. Check Flutter version (v2.0.4) and install packages locally.

```
cd petopia
flutter pub get
```

2. Configure Firebase database. See [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup) for more infomation.

First, open the default Xcode workspace by running open ios/Runner.xcworkspace in a terminal window from `/petopia` directory.

Then move the file [GoogleService-Info.plist](https://drive.google.com/file/d/1dXFtLKJEfryJ5_nHigqkEsYfUbwHGPbc/view?usp=sharing) ` into the `Runner/Runner` directory.  

3. Run Flutter app in `/petopia` directory.

```
flutter run
```

Notes: If an error related to CocoaPods is reported, [install and set up CocoaPods](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices) using the following command.

```
sudo gem install cocoapods
```

### Working Status

Yihua Cai: Currently working on the Home page.

Jiaqi Liu: Completed [data model design](https://docs.google.com/presentation/d/1Tv2inE65sjLrQshEj7lx6RkJ1eSqf2vJMqGLYyahADI/edit?usp=sharing), now working on writing data model and My Pet page.



## Getting Started with Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

