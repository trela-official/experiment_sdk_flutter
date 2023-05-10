<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Amplitude Experiment implementation for Flutter. This is a non official package provided by ProductMinds.

## Features

`fetch`: Fetch experiments assigned to user. You can use some properties as below:
<br />
`variant`: Fetch assigned variant for each experiment. You can use some properties as below:
<br />
`clear`: Clear all SDK cache
<br />
`exposure` (works only with **initializeWithAmplitude** or by providing a custom **exposureTrackingProvider**)_: Track exposure for assigned variant in assigned experiment

## Getting started

In order to start using this package you **must** have properly defined an Amplitude Account and Project as well Amplitude Experiment. When you have already setted your experiment, you should create a `deployment` and this api key is the artifact that this SDK uses.

### **The init functions**

`initialize`: This function is going to return an ExperimentClient instance that you should use to start instrumentation. Look at this:

```dart
Experiment.initialize({ required String apiKey, ExperimentConfig? experimentConfig });
```

`initializeWithAmplitude`: This function is going to return the same ExperimentClient instance configs but will try to link an Amplitude Analytic as exposure tracker.
NOTE: This will work only if you've already installed and setup an analytics plugin

```dart
Experiment.initializeWithAmplitude({ required String apiKey, ExperimentConfig? experimentConfig });
```

#### **Config Object**

```dart
class ExperimentConfig {
  final bool? debug;
  final String? instanceName;
  final ExperimentVariant? fallbackVariant;
  final ExperimentVariantSource? source;
  final int? fetchTimeoutMillis;
  final bool? retryFetchOnFailure;
  final bool? automaticExposureTracking;
  final ExperimentExposureTrackingProvider? exposureTrackingProvider;

  ExperimentConfig(
      {this.debug = false,
      this.instanceName = 'default-instance',
      this.fallbackVariant,
      this.source,
      this.fetchTimeoutMillis,
      this.retryFetchOnFailure,
      this.automaticExposureTracking = false,
      this.exposureTrackingProvider});
```

## Usage

To `fetch` experiments for user:

```dart
Experiment.fetch({ String? userId, String? deviceId, Map<String, dynamic>? userProperties });
```

To get `variant` for specific experiment:
```dart
Experiment.variant(String flagKey);
```

To get all `variants` and `experiments` that this user is assigned to:
```dart
Experiment.all();
```

To `clear` all cache data:
```dart
Experiment.clear();
```

To track `exposure` event:
```dart
Experiment.exposure(String flagKey);
``` 
NOTE: works only with **initializeWithAmplitude** or by providing a custom **exposureTrackingProvider**

## Additional information
This package is basically an wrappper to [Experiment Evaluation API](https://www.docs.developers.amplitude.com/experiment/apis/evaluation-api/) maintened by Product Minds team. If you have any problem with this license or usage, please email to antonny.santos@productminds.io.

