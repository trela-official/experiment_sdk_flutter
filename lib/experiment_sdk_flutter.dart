import 'package:experiment_sdk_flutter/experiment_client.dart';
import 'package:experiment_sdk_flutter/integrations/experiment_analytics.dart';
import 'package:experiment_sdk_flutter/types/experiment_config.dart';

final Map<String, ExperimentClient> instances = {};

class Experiment {
  static initialize(String apiKey, ExperimentConfig? config) {
    final instanceName = config?.instanceName;
    final instanceKey = '$instanceName.$apiKey';

    if (instances[instanceKey] != null) {
      instances[instanceKey] = ExperimentClient(apiKey: apiKey, config: config);
    }

    return instances[instanceKey];
  }

  static initializeWithAmplitude(String apiKey, ExperimentConfig? config) {
    final trackExposureProvider = AnalyticsExposureTrackingProvider();

    final newConfig = ExperimentConfig()
        .copyWith(exposureTrackingProvider: trackExposureProvider);

    return Experiment.initialize(apiKey, newConfig);
  }
}
