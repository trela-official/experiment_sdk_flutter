import 'package:experiment_sdk_flutter/http_client.dart';
import 'package:experiment_sdk_flutter/local_storage.dart';
import 'package:experiment_sdk_flutter/types/experiment_config.dart';
import 'package:experiment_sdk_flutter/types/experiment_fetch_input.dart';
import 'package:experiment_sdk_flutter/types/experiment_sources.dart';
import 'package:experiment_sdk_flutter/types/experiment_variant.dart';

class GetSourceAndVariantResult {
  final ExperimentVariant? variant;
  final ExperimentVariantSource source;

  GetSourceAndVariantResult({this.variant, required this.source});
}

class AmplitudeExperiment {
  final ExperimentConfig? _config;
  final HttpClient _httpClient;
  final LocalStorage _localStorage;

  AmplitudeExperiment({required String apiKey, ExperimentConfig? config})
      : _config = config,
        _httpClient = HttpClient(apiKey: apiKey),
        _localStorage = LocalStorage(apiKey: apiKey) {
    _localStorage.load();
  }

  fetch(
      {String? userId,
      String? deviceId,
      Map<String, dynamic>? userProperties}) async {
    final input = ExperimentFetchInput(
        userId: userId, deviceId: deviceId, userProperties: userProperties);

    await _httpClient.get(input);

    _storeVariants();
  }

  ExperimentVariant? variant(String flagKey) {
    var variant = _httpClient.fetchResult[flagKey]?.toVariant();

    if (variant == null || variant.value!.isEmpty) {
      final result = _getSourceAndVariant(flagKey);

      variant = result?.variant;
    }

    return variant;
  }

  exposure(String key) {
    final exposureTrackerProvider = _config?.exposureTrackingProvider;
    final sourceAndVariant = _getSourceAndVariant(key);
    final source = sourceAndVariant?.source;
    final variant = sourceAndVariant?.variant;
    final instanceName = _config?.instanceName ?? 'default-instance';

    if (source != null &&
        isFallback(source) &&
        exposureTrackerProvider != null &&
        variant == null) {
      exposureTrackerProvider.exposure(key, null, instanceName);
    } else if (variant != null && exposureTrackerProvider != null) {
      exposureTrackerProvider.exposure(key, variant, instanceName);
    }
  }

  clear() {}

  GetSourceAndVariantResult? _getSourceAndVariant(String key) {
    final sourceVariant = _httpClient.fetchResult[key]?.toVariant();

    if (sourceVariant != null) {
      return GetSourceAndVariantResult(
          variant: sourceVariant,
          source: ExperimentVariantSource.initialVariants);
    }

    if (_config?.fallbackVariant != null) {
      return GetSourceAndVariantResult(
          source: ExperimentVariantSource.fallbackConfig,
          variant: _config?.fallbackVariant);
    }

    return null;
  }

  _storeVariants() {
    _localStorage.clear();

    _httpClient.fetchResult.forEach((key, value) {
      _localStorage.put(key, value.toVariant());
    });

    _localStorage.save();
  }

  _log() {}
}
