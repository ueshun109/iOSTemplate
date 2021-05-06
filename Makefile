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
	cd ../BuildTools
	SDKROOT=macosx
	swift run -c release license-plist --package-path Package.swift  --output-path ../App/Settings.bundle