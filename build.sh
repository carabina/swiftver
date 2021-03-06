#!/bin/bash

# Get a list of all schemes, then build each.
xcodebuild -project SwiftVer.xcodeproj -list | \
	sed -n '/Schemes/,/^$/p' | \
	grep -v "Schemes:" | \
	while read scheme; do
		if [ ! -z "$scheme" ]; then
			echo "Building ${scheme}…"

			xcodebuild -project SwiftVer.xcodeproj \
				-scheme "${scheme}" \
				-configuration Release
		fi
	done

iOSVersions_TRAVIS=(8.1 8.2 8.3 8.4 9.0 9.1 9.2 9.3 10.0 10.1)
iOSVersions_LOCAL=(8.4 9.3 10.1)

[[ $TRAVIS ]] && iOSVersions=${iOSVersions_TRAVIS[*]} || iOSVersions=${iOSVersions_LOCAL[*]}

for iOSVersion in ${iOSVersions[@]}; do
	xcodebuild -project SwiftVer.xcodeproj -scheme "SwiftVer iOS" -destination "platform=iOS Simulator,name=iPhone 5,OS=${iOSVersion}" clean test
	xcodebuild -project SwiftVer.xcodeproj -scheme "SwiftVer iOS" -destination "platform=iOS Simulator,name=iPad Air,OS=${iOSVersion}" clean test
done

tvOSVersions_TRAVIS=(9.0 9.1 9.2 10.0)
tvOSVersions_LOCAL=(10.0)

[[ $TRAVIS ]] && tvOSVersions=${tvOSVersions_TRAVIS[*]} || iOSVersions=${tvOSVersions_LOCAL[*]}

for tvOSVersion in ${tvOSVersions[@]}; do
	xcodebuild -project SwiftVer.xcodeproj -scheme "SwiftVer tvOS" -destination "platform=tvOS Simulator,name=Apple TV 1080p,OS=${tvOSVersion}" clean test
done

xcodebuild -project SwiftVer.xcodeproj -scheme "SwiftVer macOS" -destination 'platform=OS X,arch=x86_64' clean test