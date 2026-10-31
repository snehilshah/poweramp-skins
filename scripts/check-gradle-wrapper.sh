#!/usr/bin/env bash
# Checks gradle/wrapper/gradle-wrapper.jar against the checksum Gradle
# publishes for the version in gradle-wrapper.properties.
set -euo pipefail

cd "$(dirname "$0")/.."
VERSION=$(sed -n 's|^distributionUrl=.*/gradle-\(.*\)-bin\.zip$|\1|p' gradle/wrapper/gradle-wrapper.properties)
EXPECTED=$(curl -fsSL "https://services.gradle.org/distributions/gradle-$VERSION-wrapper.jar.sha256")
echo "$EXPECTED  gradle/wrapper/gradle-wrapper.jar" | sha256sum --check
