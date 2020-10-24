# ConcurrentDictionary

[![CI Linux](https://github.com/horothesun/ConcurrentDictionary/workflows/CI%20Linux/badge.svg)](https://github.com/horothesun/ConcurrentDictionary/blob/master/.github/workflows/ci-linux.yml)
[![CI macOS](https://github.com/horothesun/ConcurrentDictionary/workflows/CI%20macOS/badge.svg)](https://github.com/horothesun/ConcurrentDictionary/blob/master/.github/workflows/ci-macos.yml)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)

Thread-safe Swift dictionary.

## Generate Xcode project

```bash
swift package generate-xcodeproj
```

## Testing

### macOS

```bash
swift test
```

### Docker Linux

IMPORTANT: regenerate Linux test list executing

```bash
swift test --generate-linuxmain
```

Execute on base `swift:5.2` image

```bash
docker run --rm \
    --volume "$(pwd):/package" \
    --workdir '/package' \
    swift:5.2 \
    /bin/bash -c 'swift test'
```

or create a new image based on `Dockerfile` and run it

```bash
docker build --tag concurrent-dictionary .
docker run --rm concurrent-dictionary
```
