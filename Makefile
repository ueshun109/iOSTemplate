PLATFORM_IOS = iOS Simulator,name=iPhone 13,OS=15.0

.PHONY: archive
archive:
	@if [ -d .build/archive.xcarchive ]; then \
		set -o pipefail && rm -rf .build/archive.xcarchive | echo "Deleted archive"; \
	fi
	@agvtool next-version -all
	@xcodebuild \
		-workspace iOSTemplate.xcworkspace \
		-scheme "App (Staging project)" \
		-destination platform="$(PLATFORM_IOS)" \
		-configuration Release \
		archive \
		-archivePath .build/archive \

.PHONY: bundle-install
bundle-install:
	@bundle config set path '.bundle/'
	@bundle install

.PHONY: debug-build
debug-build:
	@xcodebuild \
		-workspace iOSTemplate.xcworkspace \
		-scheme "App (Staging project)" \
		-destination platform="$(PLATFORM_IOS)"

.PHONY: generate-fastlane-session
generate-fastlane-session:
	@bundle exec ruby spaceauth.rb

.PHONY: generate-license
generate-license:
	SDKROOT=macosx
	swift run -c release --package-path ./BuildTools license-plist --output-path App/Settings.bundle --package-paths ./Package.swift

.PHONY: test
test:
#	swift package clean
	@xcodebuild test \
		-workspace iOSTemplate.xcworkspace \
		-scheme "App (Staging project)" \
		-destination platform="$(PLATFORM_IOS)"

.PHONY: update-certificate
update-certificate:
	@bundle exec fastlane create_certs
