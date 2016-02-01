run:
	xctool --version
	@echo
	xctool -project App/HangulSwift.xcodeproj -scheme HangulSwift -sdk iphonesimulator test
