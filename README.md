# Caching Package

A Flutter package for efficient key-value data caching with optional expiration support. This package provides a simple yet powerful way to cache data in your Flutter applications using SharedPreferences as the underlying storage mechanism.

## Features

- Simple key-value data caching
- Optional expiration time for cached items
- Type-safe data retrieval
- Easy to use API
- Built on top of SharedPreferences

## Demo

### Saving Data to Cache
![Saving to Cache](caching1.jpg)

### Retrieving Data from Cache
![Retrieving from Cache](caching2.jpg)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  caching_package: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Import the package

```dart
import 'package:caching_package/caching_package.dart';
```

### Store data in cache

```dart
// Store data without expiration
await CacheManager.set('greeting', 'Hello World');

// Store data with expiration (e.g., 1 hour)
await CacheManager.set('greeting', 'Hello World', 
    expireAfter: Duration(hours: 1));
```

### Retrieve data from cache

```dart
// Get cached data
final greeting = await CacheManager.get<String>('greeting');
if (greeting != null) {
    print('Retrieved from cache: $greeting');
} else {
    print('No cached data found or data has expired');
}
```

### Remove specific cached data

```dart
await CacheManager.remove('greeting');
```

### Clear all cached data

```dart
await CacheManager.clear();
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/yourusername/caching_package/issues).

## License

This project is licensed under the MIT License - see the LICENSE file for details.