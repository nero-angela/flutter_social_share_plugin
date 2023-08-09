import 'dart:async';

import 'package:flutter/services.dart';

typedef OnCancelHandler = void Function();
typedef OnErrorHandler = void Function(String error);
typedef OnSuccessHandler = void Function(String postId);

class SocialSharePlugin {
  static const MethodChannel _channel = MethodChannel('social_share_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> shareToFeedInstagram({
    String type = 'image/*',
    required String path,
    OnSuccessHandler? onSuccess,
    OnErrorHandler? onError,
    OnCancelHandler? onCancel,
  }) async {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onSuccess":
          onSuccess?.call(call.arguments);
          break;
        case "onError":
          onError?.call(call.arguments);
          break;
        case "onCancel":
          onCancel?.call();
          break;
      }
    });
    return _channel.invokeMethod('shareToFeedInstagram', <String, dynamic>{
      'type': type,
      'path': path,
    });
  }

  static Future<bool?> shareToFeedFacebook({
    String? caption,
    required String path,
  }) async {
    final completer = Completer<bool?>();
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onSuccess":
          completer.complete(true);
          break;
        case "onError":
          completer.complete(false);
          break;
        case "onCancel":
          completer.complete(null);
          break;
      }
    });
    await _channel.invokeMethod('shareToFeedFacebook', <String, dynamic>{
      'caption': caption,
      'path': path,
    });
    return completer.future;
  }

  static Future<dynamic> shareToFeedFacebookLink({
    String? quote,
    required String url,
    OnSuccessHandler? onSuccess,
    OnCancelHandler? onCancel,
    OnErrorHandler? onError,
  }) async {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onSuccess":
          onSuccess?.call(call.arguments);
          break;
        case "onError":
          onError?.call(call.arguments);
          break;
        case "onCancel":
          onCancel?.call();
          break;
      }
    });
    return _channel.invokeMethod('shareToFeedFacebookLink', <String, dynamic>{
      'quote': quote,
      'url': url,
    });
  }

  static Future<dynamic> shareToTwitterLink({
    String? text,
    required String url,
    OnSuccessHandler? onSuccess,
    OnErrorHandler? onError,
    OnCancelHandler? onCancel,
  }) async {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onSuccess":
          onSuccess?.call(call.arguments);
          break;
        case "onError":
          onError?.call(call.arguments);
          break;
        case "onCancel":
          onCancel?.call();
          break;
      }
    });
    return _channel.invokeMethod('shareToTwitterLink', <String, dynamic>{
      'text': text,
      'url': url,
    });
  }
}
