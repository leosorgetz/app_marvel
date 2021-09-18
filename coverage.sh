#!/bin/bash

LCOV_FILE=./coverage/lcov.info

# paths to exclude
CORE_DI_PATH=lib/src/core/di.dart
UI_DI_PATH=lib/src/ui/di.dart
SHARED_PATH=lib/src/core/shared/*
STATES_PATH=lib/src/ui/shared/states/*
CONFIG_PATH=lib/config/*
ERRORS_PATH=lib/src/core/errors/*
#ENTITIES_PATH=lib/src/core/entities/*
#SERVICES_PATH=lib/src/core/services/*
#MODELS_GENERATED_PATH=lib/src/core/models/*.g.dart
#CUSTOM_LOCALIZATION_PATH=lib/src/core/custom_localization.dart
#PRESENTERS_DI_PATH=lib/src/presenters/di.dart
#CONTRACTS_PATH=lib/src/modules_contracts/*
#STATES_PATH=lib/src/presenters/shared/states/*
#HELPERS_PATH=lib/src/presenters/shared/helpers/*
#CONSTANTS_PATH=lib/src/presenters/shared/constants/*
#MIXINS_PATH=lib/src/presenters/shared/mixins/*
#LIB_PATH=lib/src/presenters/shared/lib/*

if [ -f "$LCOV_FILE" ]; then
  echo "$LCOV_FILE exists."
  flutter test --coverage --merge-coverage
else
  echo "$LCOV_FILE does not exist."
  flutter test --coverage
fi

lcov --remove coverage/lcov.info "${CORE_DI_PATH}" "${UI_DI_PATH}" "${SHARED_PATH}" "${STATES_PATH}" "${CONFIG_PATH}" "${ERRORS_PATH}" -o coverage/lcov.info &&
  genhtml -o coverage coverage/lcov.info &&
  open coverage/index.html
