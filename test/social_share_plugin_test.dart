import 'package:flutter_test/flutter_test.dart';
import 'package:social_share_plugin/social_share_plugin.dart';

void main() {
  test('getPlatformVersion', () async {
    expect(await SocialSharePlugin.platformVersion, '42');
  });
}
