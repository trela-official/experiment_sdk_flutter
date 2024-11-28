import 'package:experiment_sdk_flutter/experiment_client.dart';
import 'package:experiment_sdk_flutter/types/experiment_config.dart';

final Map<String, ExperimentClient> instances = {};

// Experiment class is the initial main point of contact and responsible to construct ExperimentClient
class Experiment {
  /// Initialize basic ExperimentClient
  static ExperimentClient initialize(
      {required String apiKey, ExperimentConfig? config}) {
    final instanceName = config?.instanceName;
    final instanceKey = '$instanceName.$apiKey';

    if (instances[instanceKey] == null) {
      instances[instanceKey] = ExperimentClient(apiKey: apiKey, config: config);
    }

    return instances[instanceKey]!;
  }

  /// Initialize ExperimentClient with Amplitude instance to handle exposure events
  static ExperimentClient initializeWithAmplitude(
      {required String apiKey, ExperimentConfig? config}) {
    final newConfig = config ?? ExperimentConfig();

    return Experiment.initialize(apiKey: apiKey, config: newConfig);
  }
}
