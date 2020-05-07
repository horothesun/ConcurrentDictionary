# ConcurrentDictionary

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

Execute on base `swift:5.2` image

```bash
docker run --rm \
    --volume "$(pwd):/package" \
    --workdir "/package" \
    swift:5.2 \
    /bin/bash -c "swift test --build-path ./.build/linux"
```

or create a new image based on `Dockerfile` and run it

```bash
docker build --tag concurrent-dictionary .
docker run --rm concurrent-dictionary
```
