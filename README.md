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

Then move the file [GoogleService-Info.plist](https://drive.google.com/file/d/1dXFtLKJEfryJ5_nHigqkEsYfUbwHGPbc/view?usp=sharing) into the `Runner/Runner` directory.  

3. Run Flutter app in `/petopia` directory.

```
flutter run
```

Notes: If an error related to CocoaPods is reported, [install and set up CocoaPods](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices) using the following command.

```
sudo gem install cocoapods
```

4. To solve connectivity problem in Emulator(wifi/internet, which is used by Google Maps API), change the DNS address of your network to 8.8.8.8 (Google's DNS) or another of your preference.

MacOSX:

Open "System Preferences" Click on "Network" Select the network which your computer is connected click on "Advanced" Select "DNS", Select the "+" button, type "8.8.8.8" (Google's DNS) or if you prefer OpenDNS, "208.67.222.222" Select "Ok" and "Apply".

5. Please put Google Maps API key(APIKey.plist) in the following path:

```
ios/Runner.xcodeproj/APIKey.plist
```

### Working Status

Yihua Cai: Currently working on the Home page.

Jiaqi Liu: Completed [data model design](https://docs.google.com/presentation/d/1Tv2inE65sjLrQshEj7lx6RkJ1eSqf2vJMqGLYyahADI/edit?usp=sharing), now working on writing data model and My Pet page.

Yuting Liu: Working on Nearby page.

Sijie Lin: Working on Store page & Profile page.

## Getting Started with Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

