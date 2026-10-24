# actions-ubuntu-android

[`catthehacker/ubuntu:act-latest`](https://github.com/catthehacker/docker_images) with the Android SDK, for Forgejo and act runners.

- SDK at `/opt/android-sdk` (`ANDROID_HOME`, `ANDROID_SDK_ROOT`)
- Licenses accepted
- `build-tools;36.0.0`, `platforms;android-37.0`

Gradle downloads any other SDK package a build needs into the same directory.

## Usage

Add a label to the runner config:

```yaml
runner:
  labels:
    - android:docker://ghcr.io/brodock/actions-ubuntu-android:latest
```

Then use it in a workflow, without `setup-android`:

```yaml
jobs:
  build:
    runs-on: android
```

Rebuilt weekly to pick up base image updates.
