# flutter_base_project

The Wymix Flutter base project

## Getting Started

This project is a starting point for a Flutter application.

### What do I do after cloning?

Before you get started on creating your own application from this starter project, make sure you do the following:
 * Modify the project name in the `pubspec.yaml` and the package name on Android and the Bundle Identifier on iOS
 * Remove any files or libraries you deem unnecessary (Don't need image caching? Delete the image caching library)
 * If you wish to remove git history, simply delete the .git folder and create a new one with `git init`
 * Customize the `AppTheme` to whatever you desire, or modify the `colors.xml` file to get a new palette going.
 * Setup the `nav_header.xml` and `drawer_menu.xml` layouts to your own specs.
 * Either delete the `feature` package in each module, or use it as a guideline for your application flow.
 * Code away!

### What can I do with this repo?

Fork it, modify it in any way you want, I don't care what you do.
You don't even have to give me credit (It would be appreciated though :) )

If you have any issues with this starter project, or would like to make suggestions, start a discussion in the
issues.

## Dependencies

### Runtime Dependencies

- dioc: basic DI container setup that can either be registered manually like in this project or used with a generator dependency to create the object graph through constructor analysis

- shared_preferences: shared preferences and NSUserDefaults wrapper for each mobile platform

- flutter_secure_storage: storage to the iOS and Android keystore where we can save things like auth tokens

- intro_views_flutter: intro screen builder

- image_picker: launches the gallery picker or camera for each platform and returns an image for use in the app

- google_sign_in: underlying google authentication used by firebase auth

- firebase_auth: authentication with firebase using multiple id providers

- firebase_messaging: FCM based messaging library to handle real time chat between users

- quiver: Arrow/Guava style utils package handling things like null or blank checks on strings

- cupertino_icons: iOS specific icons if we need them

- rxdart: reactive extensions build on top of dart streams

- fimber: a port of `Timber` from Android to handle logging in debug builds

- fluro: advanced routing library that supports transition animations, routing to a function instead of a widget directly, and more 

- sealed_unions: Algebraic Data Type library (ADT for short) that emulates Kotlin sealed unions 

- flutter_advanced_networkimage: 

- equatable: equality checking interface in the place of proper data types in dart

- flutter_stetho: flutter plugin to setup Stetho in the Android application including the network interceptor and SQLite browser

- auto_size_text: text view that will expand or shrink based on the size of its parent

- card_settings: UI library for creating material and iOS style forms that helps with validation and data conversion

- pull_to_refresh: pull to refresh widget

- flutter_politburo: Wyrmix maintained library to handle base functions across Flutter/Hummingbird apps

- dio: advanced network client with better support for handling things like retries and logging than the standard HTTP package, which this uses internally

- dragable_flutter_list: list of items that can be dragged to reorder

- expandable: widget that handles expanding and collapsing content based on user action

- json_annotation: annotations for the json serialization generator package

- clippy_flutter: shape clipping library that conforms to material design 2 guidlines

- flutter_facebook_login: native wrapper for facebook login to handle routing the access token back to firebase login

- flutter_swiper: carousel widget with swiping gestures

- pinch_zoom_image: image viewer with support for zooming

- cached_network_image: widget that handles caching images and gifs

### Dev/Build/Test Dependencies

dherkin2 - BDD testing library

build_runner - runner required to build SQLite data classes for Tinano, or for any DI generator we want to setup later

test: - flutter test utilities

mockito: - mocking library

flutter_launcher_icons: - generator for icon files on iOS and Android
  
json_serializable: - generator that takes annotated dart objects and generates a to and from JSON method in a part file 

## Architecture

### Dependency Injection

Most objects build as part of the initial graph are contained in the `di` package. `container.dart` is where all dependencies should be bound to the graph. Graph creation happens before the app runs any UI, we need to watch the init time for this. A `ContainerProvider` widget is available to handle passing the DI container to sub components by passing a `BuildContext` to `ContainerProvider.of(context)`
