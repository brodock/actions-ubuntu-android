# sdkmanager needs Java, which the runner image doesn't have.
# Install the SDK in a throwaway stage and copy only the result.
FROM eclipse-temurin:25-jre AS sdk

ARG CMDLINE_TOOLS=15859902
ARG PACKAGES="build-tools;36.0.0 platforms;android-37.0"

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl unzip \
 && curl -fsSL -o /tmp/tools.zip https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS}_latest.zip \
 && unzip -q /tmp/tools.zip -d /tmp \
 && yes | /tmp/cmdline-tools/bin/sdkmanager --sdk_root=/opt/android-sdk --licenses > /dev/null \
 && /tmp/cmdline-tools/bin/sdkmanager --sdk_root=/opt/android-sdk $PACKAGES

FROM ghcr.io/catthehacker/ubuntu:act-latest

LABEL org.opencontainers.image.source=https://github.com/brodock/actions-ubuntu-android
LABEL org.opencontainers.image.description="catthehacker/ubuntu:act-latest with the Android SDK"

COPY --from=sdk /opt/android-sdk /opt/android-sdk

ENV ANDROID_HOME=/opt/android-sdk \
    ANDROID_SDK_ROOT=/opt/android-sdk
