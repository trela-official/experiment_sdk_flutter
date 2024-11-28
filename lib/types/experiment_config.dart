import 'package:experiment_sdk_flutter/types/experiment_sources.dart';
import 'package:experiment_sdk_flutter/types/experiment_variant.dart';

class ExperimentConfig {
  final bool? debug;
  final String? instanceName;
  final ExperimentVariant? fallbackVariant;
  final ExperimentVariantSource? source;
  final int? fetchTimeoutMillis;
  final bool? retryFetchOnFailure;
  final bool? automaticExposureTracking;

  Duration get timeout => Duration(milliseconds: fetchTimeoutMillis ?? 5000);

  ExperimentConfig({
    this.debug = false,
    this.instanceName = '\$default_instance',
    this.fallbackVariant,
    this.source,
    this.fetchTimeoutMillis,
    this.retryFetchOnFailure,
    this.automaticExposureTracking = false,
  });

  copyWith({
    bool? debug,
    String? instanceName,
    ExperimentVariant? fallbackVariant,
    ExperimentVariantSource? source,
    int? fetchTimeoutMillis,
    bool? retryFetchOnFailure,
    bool? automaticExposureTracking,
  }) {
    return ExperimentConfig(
      debug: debug ?? this.debug,
      instanceName: instanceName ?? this.instanceName,
      fallbackVariant: fallbackVariant ?? this.fallbackVariant,
      source: source ?? this.source,
      fetchTimeoutMillis: fetchTimeoutMillis ?? this.fetchTimeoutMillis,
      retryFetchOnFailure: retryFetchOnFailure ?? this.retryFetchOnFailure,
      automaticExposureTracking:
          automaticExposureTracking ?? this.automaticExposureTracking,
    );
  }
}
