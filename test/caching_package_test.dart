import 'package:caching_package/caching_package.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Cache and retrieve value', () async {
    await CacheManager.set("username", "OpenAI");
    final result = await CacheManager.get<String>("username");
    expect(result, "OpenAI");
  });

  test('Cache expiration', () async {
    await CacheManager.set("temp", "data", expireAfter: const Duration(milliseconds: 1));
    await Future.delayed(const Duration(milliseconds: 5));
    final result = await CacheManager.get<String>("temp");
    expect(result, null);
  });
}
