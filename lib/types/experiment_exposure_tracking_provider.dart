import 'package:experiment_sdk_flutter/types/experiment_variant.dart';

abstract class ExperimentExposureTrackingProvider {
  void exposure(
      String flagkey, ExperimentVariant? variant, String instanceName) {}
}
