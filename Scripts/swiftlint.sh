cd ../BuildTools
SDKROOT=macosx
swift run -c release swiftlint
swift run -c release swiftlint autocorrect --format