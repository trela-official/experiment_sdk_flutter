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

  copyWith(
      {bool? debug,
      String? instanceName,
      ExperimentVariant? fallbackVariant,
      ExperimentVariantSource? source,
      String? serverUrl,
      int? fetchTimeoutMillis,
      bool? retryFetchOnFailure,
      bool? automaticExposureTracking,
      ExperimentExposureTrackingProvider? exposureTrackingProvider}) {
    return ExperimentConfig(
        debug: debug ?? this.debug,
        instanceName: instanceName ?? this.instanceName,
        fallbackVariant: fallbackVariant ?? this.fallbackVariant,
        source: source ?? this.source,
        serverUrl: serverUrl ?? this.serverUrl,
        fetchTimeoutMillis: fetchTimeoutMillis ?? this.fetchTimeoutMillis,
        retryFetchOnFailure: retryFetchOnFailure ?? this.retryFetchOnFailure,
        automaticExposureTracking:
            automaticExposureTracking ?? this.automaticExposureTracking,
        exposureTrackingProvider:
            exposureTrackingProvider ?? this.exposureTrackingProvider);
  }
}
