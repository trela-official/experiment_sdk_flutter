import 'dart:convert';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:experiment_sdk_flutter/types/experiment_exposure_tracking_provider.dart';
import 'package:experiment_sdk_flutter/types/experiment_variant.dart';

class AnalyticsExposureTrackingProvider
    implements ExperimentExposureTrackingProvider {
  @override
  Future<void> exposure(
      String flagkey, ExperimentVariant? variant, String instanceName) async {
    final properties = {'variant': variant?.value, 'flag_key': flagkey};

    if (variant == null) {
      properties.remove('variant');
    }

    return await Amplitude.getInstance(instanceName: instanceName)
        .logEvent("\$exposure", eventProperties: properties);
  }
}
