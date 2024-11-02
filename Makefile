# Rootless Mode
ifeq ($(ROOTLESS),1)
THEOS_PACKAGE_SCHEME = rootless
endif

# Architecture and Target
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = YouTubeMusic
TARGET = iphone:clang:latest:14.0
PACKAGE_VERSION = 2.2

# Device IP and Port (change as needed)
THEOS_DEVICE_IP = 192.168.1.9
THEOS_DEVICE_PORT = 22

# Common Theos Includes
include $(THEOS)/makefiles/common.mk

# YTMusicUltimate Tweak Configuration
TWEAK_NAME = YTMusicUltimate
$(TWEAK_NAME)_FILES = $(shell find Source -name '*.xm' -o -name '*.x' -o -name '*.m')
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -DTWEAK_VERSION=$(PACKAGE_VERSION)
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos Accelerate CoreMotion GameController VideoToolbox
$(TWEAK_NAME)_OBJ_FILES = $(shell find Source/Utils/lib -name '*.a')
$(TWEAK_NAME)_LIBRARIES = bz2 c++ iconv z

# Optional Sideloading File
ifeq ($(SIDELOADING),1)
$(TWEAK_NAME)_FILES += Sideloading.xm
endif

include $(THEOS_MAKE_PATH)/tweak.mk

# LastFMYouTubeMusic Tweak Configuration
LASTFM_API_KEY = a2122aed6d4cc902642ee77d7b757333
LASTFM_API_SECRET = f11c78471b4ca0f8943caafbb73112fd

TWEAK_NAME = LastFMYouTubeMusic
$(TWEAK_NAME)_FILES = $(shell find sources -name '*.x*')
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -DAPI_KEY=@\"$(LASTFM_API_KEY)\" -DAPI_SECRET=@\"$(LASTFM_API_SECRET)\"
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation CydiaSubstrate

include $(THEOS_MAKE_PATH)/tweak.mk
