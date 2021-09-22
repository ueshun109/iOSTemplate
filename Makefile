PLATFORM_IOS = iOS Simulator,name=iPhone 12 Pro,OS=14.4

test:
	@xcodebuild test \
		-workspace iOSTemplate.xcworkspace \
		-scheme "App (Staging project)" \
		-destination platform="$(PLATFORM_IOS)"


debug-build:
	@xcodebuild \
		-workspace iOSTemplate.xcworkspace \
		-scheme "App (Staging project)" \
		-destination platform="$(PLATFORM_IOS)"

generate-license:
	SDKROOT=macosx
	swift run -c release --package-path ./BuildTools license-plist --output-path App/Settings.bundle --package-paths ./Package.swift
