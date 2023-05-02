enum ExperimentVariantSource { localStorage, initialVariants, fallbackConfig }

bool isFallback(ExperimentVariantSource source) =>
    source == ExperimentVariantSource.fallbackConfig;
