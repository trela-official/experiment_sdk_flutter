import 'dart:convert';

import 'package:experiment_sdk_flutter/types/experiment_exposure_tracking_provider.dart';
import 'package:experiment_sdk_flutter/types/experiment_variant.dart';
import 'package:flutter/services.dart';

abstract class _Amplitude {
  final MethodChannel _channel = const MethodChannel('amplitude_flutter');
}

class AnalyticsExposureTrackingProvider extends _Amplitude
    implements ExperimentExposureTrackingProvider {
  @override
  Future<void> exposure(
      String flagkey, ExperimentVariant? variant, String instanceName) async {
    final properties = {
      'instanceName': instanceName,
      'eventType': '$exposure',
      'variant': variant?.value,
      'flag_key': flagkey
    };

    if (variant == null) {
      properties.remove('variant');
    }

    await _channel.invokeMethod('logEvent', jsonEncode(properties));
  }
}
