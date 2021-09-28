PLATFORM_IOS = iOS Simulator,name=iPhone 12,OS=15.0

bundle-install:
	@bundle config set path '.bundle/'
	@bundle install

test:
#	swift package clean
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
