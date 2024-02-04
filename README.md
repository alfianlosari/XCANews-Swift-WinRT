# XCA News Swift WinRT & WinUI Windows App

![alt text](https://i.ibb.co/6mymjgR/Whats-App-Image-2024-02-04-at-18-01-06-4fb748b1.jpg)

News app for Swift on Windows, showcasing how to build Windows News Apps using the [Windows App SDK](https://github.com/microsoft/windowsappsdk) through the [Swift/WinRT](https://github.com/thebrowsercompany/swift-winrt) language projection.

## Setup

### Requirements
1. Install The Browser Company Windows Swift Build 20231213:
https://github.com/thebrowsercompany/swift-build/releases/tag/20231213.3
2. Install latest CMake: `winget install --id Kitware.CMake`
3. Windows SDK 10.0.20348.0: https://go.microsoft.com/fwlink/?linkid=2164145
4. Visual Studio Community with C++ build tools

### Video Tutorial
Follow the video tutorial on building the app from scratch: https://youtu.be/hbo98xNLzog

### VSCode

VSCode is the editor of choice for developing Windows apps on Swift. You can install it from https://code.visualstudio.com/download.

If you choose to use Visual Studio Code, you'll need to install these extensions:
- [Swift VSCode Extension](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang)
- [CMake Language Support](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)
- [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)

## Building

The build of the Windows applications is done through a combination of CMake and SPM. The CMake portion of the build handles tasks that SPM currently doesn't support. The CMake `configure` step is responsible for restoring NuGet packages and generating the Swift/WinRT bindings.

Each sample application has it's own top-level directory in this repo. You can open the corresponding `.code-workspace` file in VSCode for the sample and build using `Terminal->Run Build Task...` or by pressing `Ctrl+Shift+B`.

If you'd prefer command line builds, you can first run the configure step of the build (`cmake --preset debug`) before running `cmake --build --preset debug`.

## Application Setup / Running the Application

In order to use the WindowsAppSDK in a Swift application, there are files that need to be copied next to the `.exe` file itself, which isn't something SPM supports. The [WindowsApplicationSetup.cmake](cmake/WindowsApplicationSetup.cmake) file handles all of this as part of a post-build step. These files, along with the .exe itself, are copied to the `build\bin` folder of the repo. You can run the application from there.

### Debugging in VSCode

Debugging in VSCode is supported through LLDB. You can simply press `F5` or navigate to the `Run and Debug` (`Ctrl+Shift+D`) pane.