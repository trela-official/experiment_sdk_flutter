import 'package:experiment_sdk_flutter/types/experiment_exposure_tracking_provider.dart';
import 'package:experiment_sdk_flutter/types/experiment_sources.dart';
import 'package:experiment_sdk_flutter/types/experiment_variant.dart';

class ExperimentConfig {
  final bool? debug;
  final String? instanceName;
  final ExperimentVariant? fallbackVariant;
  final ExperimentVariantSource? source;
  final String? serverUrl;
  final int? fetchTimeoutMillis;
  final bool? retryFetchOnFailure;
  final bool? automaticExposureTracking;
  final ExperimentExposureTrackingProvider? exposureTrackingProvider;

  ExperimentConfig(
      {this.debug = false,
      this.instanceName = 'default-instance',
      this.fallbackVariant,
      this.source,
      this.serverUrl,
      this.fetchTimeoutMillis,
      this.retryFetchOnFailure,
      this.automaticExposureTracking = false,
      this.exposureTrackingProvider});
}