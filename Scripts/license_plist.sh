cd ../BuildTools
SDKROOT=macosx
swift run -c release license-plist --package-path Package.swift  --output-path ../App/Settings.bundle